# version 2 of the original script, because of a stupid limitation ("message": "failed while searching for account: error while rewinding account: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx[20295635,33]: rewinding past txn type appl is not currently supported")
# So it's not possible to check for all addresses at a specific block, making my life much harder to calculate. But it's still doable!
# This script can be reproduced by anybody to validate my information is correct. I encourage anyone to double check my stuff, I know I've made some mistakes in the past but it should be good.
# Note that the ANIRAND ASA has 6 decimals. All values you will get will be in "microANIRAND" so you have to divide by 1000000 if you want the "real" value.


# curl all accounts which ever had Anirand opted in
curl -X 'GET' 'https://algoindexer.algoexplorerapi.io/v2/assets/604643747/balances?limit=10000&include-all=true' -H 'accept: application/json' | jq -r '.balances[] | .address' > ./tmp.txt

# Remove all lines with addresses we don't want to check (ANI-ALGO Tinyman pool, ANIRAND associated addresses)
# I'll update this as I get more.
sed -i "/^JO7VWMGSF7NSIWMIG3DIUL7DD3RVPIC7CBASGJLRFUMNTMXKGCPS2BYC7I/d" ./tmp.txt
sed -i "/^ANILPXQMFPC3Z3HWNJDQJOXIBQE462WVGV67GSYVPVDRFYPPTSNEPQ7ZUQ/d" ./tmp.txt
sed -i "/^ANISTK3FP3ESRUN6576LNEK2M7PPK2WDJOFG6OCH224KHVQMCUS7AO75NI/d" ./tmp.txt
sed -i "/^WDJG7PTXHKMUULIC4SLPVKDHP2EQHA2PW5G5CSN2LZ2RR43UF2GO4Z26OE/d" ./tmp.txt

# create a directory to work out of, otherwise it's gonna get crowded
mkdir addresses-txsv2

# Grab all transactions for each account from that list between block 19234199 (Anirand creation) and 20069879 (Anirand Rugpull).
# This will create close to ~1400 different text files with the all transactions to parse through later.

while IFS= read -r line; do
curl -X GET "https://algoindexer.algoexplorerapi.io/v2/accounts/${line}/transactions?min-round=19234199&max-round=20069879&asset-id=604643747" -H 'accept: application/json' >> "./addresses-txsv2/${line}.txt"
done < ./tmp.txt

# Calculate the total for each addresses. This calculates all outgoing transactions and all incoming transactions of the asset, and then sums it up and dumps it in a text file called totals.txt

while IFS= read -r line; do
received=$(cat "./addresses-txsv2/${line}.txt" | jq -r '.transactions[]."asset-transfer-transaction" | select (.receiver=="'$line'") | .amount' | paste -sd+ | bc)
sent=$(cat "./addresses-txsv2/${line}.txt" | jq -r '.transactions[]."asset-transfer-transaction" | select (.receiver!="'$line'") | .amount' | paste -sd+ | bc)
closedreceived=$(cat "./addresses-txsv2/${line}.txt" | jq -r '.transactions[]."asset-transfer-transaction" | select (.receiver=="'$line'") | ."close-amount"' | paste -sd+ | bc)
closedsent=$(cat "./addresses-txsv2/${line}.txt" | jq -r '.transactions[]."asset-transfer-transaction" | select (.receiver!="'$line'") | ."close-amount"' | paste -sd+ | bc)
if [ -z $received ]; then received=0;fi
if [ -z $sent ]; then sent=0;fi
if [ -z $closedreceived ]; then closedreceived=0;fi
if [ -z $closedsent ]; then closedsent=0;fi
totalreceived=$(echo $received+$closedreceived | bc)
totalsent=$(echo $sent+$closedsent | bc)
total=$(echo $totalreceived-$totalsent | bc)
printf "$line $total\n" >> ./totalsv2.txt
done < ./tmp.txt

# Delete all lines ending with " 0", since those have traded some ANIRAND but got out before the rugpull so their balance at rugpull time was 0
sed -i '/\s0$/d' ./totalsv2.txt

# This gives us around ~600 addresses with a positive balance of Anirand at block 20069879
# That was pretty interesting to figure out.
# To add up the totals, you can do something like that
totalanirand=$(cat ./totalsv2.txt | awk '{print $2}' | paste -sd+ | bc)

# And then you can divide each line by this total to get the "share" of the relief fund for each individual address.
# I'll do it by reading from one file and dropping it in another file, it's easier than using "sed -i" to replace and I already worked way too much on this stuff for today.

while IFS= read -r line; do
account=$(awk 'NR==1{print$1}' ./totalsv2.txt)
qtyofanirand=$(awk 'NR==1{print$2}' ./totalsv2.txt)
share=$( echo "scale=12; $qtyofanirand/$totalanirand" | bc)
printf "$account $share\n" >> ./totalshares.txt
sed -i '1d' ./totalsv2.txt
done < ./totalsv2.txt

# Remove any addresses with a ratio of 0, I mean I'm going with 12 decimals here! Thankfully there's only one that had like 0.000003 Anirand so sorry but no relief fund for you :(
sed -i '/\s0$/d' ./totalshares.txt

# And there you go. All addresses who had ANIRAND at the rugpull block and their share of the relief fund.

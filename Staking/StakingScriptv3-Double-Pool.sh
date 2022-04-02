#Tested on Kubuntu 20.04 LTS but should work on anything basically as long as youve got a working node.
#Required optional packages : jq curl bc
#Latest OGS-NURD script used as an example, modify the values for whatever you need

#Unit Name of the ASA
NAME=OGS-NURD

#Asset-id of the ASA
ASA=613608234
ASA2=330168845

#1 Unit of the ASA in microUnits
ASAUNIT=1000000000
ASAUNIT2=100

#Minimum balance of the ASA to hold to qualify, non inclusive. In microUnits. For instance, 1000 AFDs is 100000000000 microUnits because it has 8 decimals.
STAKEMINBAL=999999999
STAKEMINBAL2=9999

# Percent of daily staking in numerical value. In this case 1% is 0.01
STAKEDAILY=0.00018

#Notes to attach to each transaction.
STAKENOTE="TheAlgoFaucet.com"

#Account on your node which will distribute the rewards
DISTRIBUTER=FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ

#Purestake and CoinMarketCap API keys
APIKEY=asdfasdfasdfasdfasdfasdf
CMCAPIKEY=asdfasdfasdfasdf

#Address of the Tinyman Pools
TINYMANPOOL=EXZTTSDQMKODAUGJSQ7SISZK45LYEL7CKU4Q6DYUAJC7AFTMQ3FU4LIR7M
TINYMANPOOL2=DNVDPFKN36KMACLXPGZGM66KO5RZBQEQPAZRBFQ57U3JJV5DYILIZKC72U

#Blacklist addresses. I suggest putting Creator and other dev accounts.
#Leave the 0s in if you won't use all of them otherwise the script will wipe the text file created.
#If you need more than 10, it should be pretty straight forward to add more.
BLACKLIST0=SSV6SKTMN3IOJO6SWUAT5ERZOBC5K44CQPOH5O7NSXJLGFGU73WUQ7DPGA
BLACKLIST1=4ZK3UPFRJ643ETWSWZ4YJXH3LQTL2FUEI6CIT7HEOVZL6JOECVRMPP34CY
BLACKLIST2=BBFOJHKSWA4SSS7FUFMORM43C2NEYTF2DXFA2N3QTNS5RAFOZSKYQHJZPM
BLACKLIST3=0
BLACKLIST4=0
BLACKLIST5=0
BLACKLIST6=0
BLACKLIST7=0
BLACKLIST8=0
BLACKLIST9=0


# Don't touch this.
FOLDER="$NAME"

# Path you want to use for the ASA. Dont worry about creating them, the script does that right after.
FOLDERPATH=/home/algouser/other-stake/${FOLDER}
TMPPATH=/home/algouser/other-stake/${FOLDER}/tmp
LOGPATH=/home/algouser/other-stake/${FOLDER}/log

################FROM HERE ITS ONLY UNCOMMENTING THE TRANSACTION MAKING LINES WITH goal AND THE LAST PORTION WHEN YOURE absolutely READY##########################


#Creates the paths required, will get commented out by the next sed
# mkdir -p $FOLDERPATH
# mkdir -p $TMPPATH
# mkdir -p $LOGPATH

#Comment out all lines with mkdir inside this script file, including itself.
#This sed was fucking ridiculous to make. It took me fucking 1 hour for this ONE line.
#If your ASA is called mkdir or for some reason you want to put mkdir in your ASA message, you better put it in all caps so it doesn't interfere with this.
#I cannot honestly describe how fucking beautiful this is. This sed comments ITSELF out after one pass!
#Ridiculous lol.
# sed -i '/^[^#]/ s/\(^.*mkdir.*$\)/#\ \1/' $0
#Okay I m done

ASAINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$ASA"') | .amount')

ASAINPOOL2=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL2}/" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$ASA2"') | .amount')

# curl the price from CMC
ALGOPRICE=$(curl -H "X-CMC_PRO_API_KEY: ${CMCAPIKEY}" -H "Accept: application/json" -G https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=ALGO | jq -r .data.ALGO[].quote.USD.price)
# curl amount of Algo in pool
ALGOINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r .account.amount)
ALGOINPOOL2=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL2}/" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r .account.amount)
#calculate the swap ratio between ALGO and ASA
SWAPRATIO=$(echo "scale=8; $ALGOINPOOL*$ASAUNIT/$ASAINPOOL/1000000" | bc)
SWAPRATIO2=$(echo "scale=8; $ALGOINPOOL2*$ASAUNIT2/$ASAINPOOL2/1000000" | bc)
#Calculate the ratio between the 2 ASAs
ASASWAPRATIO=$(echo "scale=8; $SWAPRATIO/$SWAPRATIO2" |bc)

# curl a list of accounts with the minimum balance of the ASA on purestake and format it to a file with ADDRESS AMOUNT. If you want to use another API, change the url.
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${ASA2}/balances?currency-greater-than=${STAKEMINBAL2}&limit=10000" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/stake.txt"

curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${ASA}/balances?currency-greater-than=${STAKEMINBAL}&limit=10000" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/2stake.txt"

# curl a list of accounts with the minimum balance of the LP-Token ASA on purestake and format it to a file with ADDRESS AMOUNT. If you want to use another API, change the url.
#curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${POOLASA}/balances?currency-greater-than=${POOLMINBAL}" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/pool.txt"


# Remove lines with BLACKLIST items for Staking
sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/stake.txt"
sed -i "/^${TINYMANPOOL2}/d" "${TMPPATH}/stake.txt"
sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST0}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST1}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST2}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST3}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST4}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST5}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST6}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST7}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST8}/d" "${TMPPATH}/stake.txt"
sed -i "/^${BLACKLIST9}/d" "${TMPPATH}/stake.txt"

sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${TINYMANPOOL2}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST0}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST1}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST2}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST3}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST4}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST5}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST6}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST7}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST8}/d" "${TMPPATH}/2stake.txt"
sed -i "/^${BLACKLIST9}/d" "${TMPPATH}/2stake.txt"

# Copy the text file with results in the log folder
cp "${TMPPATH}/stake.txt" "${LOGPATH}/stake-log`date +"%Y%m%d_%H%M"`.txt"

# Create increment variable, start loop reading the text file stake.txt
i=0
while IFS= read -r line; do

# Create TX variables
account=$(awk 'NR==1{print$1}' "${TMPPATH}/stake.txt")
stake=$(awk 'NR==1{print$2}' "${TMPPATH}/stake.txt")
reward=$(echo $stake*$STAKEDAILY*$ASAUNIT/$ASASWAPRATIO/$ASAUNIT2|bc)
REWARDPRICE=$(echo "scale=6; $reward*$SWAPRATIO*$ALGOPRICE/$ASAUNIT" | bc)

#DRYRUN PART. Creates a text file with what will be sent. I highly suggest you view this file to adjust your version of the script. Comment out when ready for live.
echo STAKE $account $reward $ASA $i $REWARDPRICE USD >> ${TMPPATH}/dryrun.txt

#BUILD STAKE TRANSACTION. UNCOMMENT BELOW WHEN YOURE READY FOR LIVE
#goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note="${STAKENOTE} sid=${i} currentvalue=${REWARDPRICE} USD" --out="${TMPPATH}/staketmp${i}"

#Delete the current line in the file it's looping
sed -i '1d' "${TMPPATH}/stake.txt"

# Increment the loop
i=$(($i+1))

done < "${TMPPATH}/stake.txt"
rm "${TMPPATH}/stake.txt"
######################################END OF ASA1 STAKING LOOP########################################
######################################START OF ASA2 STAKING LOOP######################################
# Copy the text file with results in the log folder
cp "${TMPPATH}/2stake.txt" "${LOGPATH}/2stake-log`date +"%Y%m%d_%H%M"`.txt"

# Create increment variable, start loop reading the text file stake.txt
while IFS= read -r line; do

# Create TX variables
account=$(awk 'NR==1{print$1}' "${TMPPATH}/2stake.txt")
stake=$(awk 'NR==1{print$2}' "${TMPPATH}/2stake.txt")
reward=$(echo $stake*$STAKEDAILY*$ASAUNIT2*$ASASWAPRATIO/$ASAUNIT |bc)
REWARDPRICE=$(echo "scale=6; $reward*$SWAPRATIO2*$ALGOPRICE/$ASAUNIT2" | bc)

#DRYRUN PART. Creates a text file with what will be sent. I highly suggest you view this file to adjust your version of the script. Comment out when ready for live.
echo 2STAKE $account $reward $ASA2 $i $REWARDPRICE USD >> ${TMPPATH}/dryrun.txt

#BUILD STAKE TRANSACTION. UNCOMMENT BELOW WHEN YOURE READY FOR LIVE
#goal asset send --from=$DISTRIBUTER --assetid=$ASA2 --to=$account --fee=1000 --amount=$reward --note="${STAKENOTE} 2sid=${i} currentvalue=${REWARDPRICE} USD" --out="${TMPPATH}/staketmp${i}"

#Delete the current line in the file it's looping
sed -i '1d' "${TMPPATH}/2stake.txt"

# Increment the loop
i=$(($i+1))

done < "${TMPPATH}/2stake.txt"
rm "${TMPPATH}/2stake.txt"
######################################END OF ASA2 STAKING LOOP########################################

# I suggest adding this script to a cron job
# On most distros, its  crontab -e
# Something like this for everyday at 21:00
# 0 21 * * * /path/to/the/script.sh
# Oh and do you remember that sed I made? It was so beautiful.
# Seriously, got back up and look at it. I don't think Ive ever been prouder of anything in my life up to this point. Its my masterpiece.

######################################PRODUCTION - LIVE ######################################

# Uncomment the lines below once you know youre 100% certain youve got the right results from the dry runs.



#cat ${TMPPATH}/staketmp* > ${TMPPATH}/unsigned.txn
#goal clerk sign --infile=${TMPPATH}/unsigned.txn --outfile=${TMPPATH}/signed.stxn
#goal clerk rawsend -N --filename=${TMPPATH}/signed.stxn
#sleep 15
#goal clerk rawsend -N --filename=${TMPPATH}/signed.stxn
#sleep 15
#goal clerk rawsend -N --filename=${TMPPATH}/signed.stxn
#rm ${TMPPATH}/*


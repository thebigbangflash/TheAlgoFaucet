#!/bin/bash

#Put this script in a cronjob, I personally run it every 5 mins. Need to set the MINROUND manually the first time.

#Use a file to store the current round as a variable between script executions
MINROUND=$(cat /home/algo/MINROUND.txt)
MAXROUND=$(curl --connect-timeout 5 --max-time 3 --retry 6 --retry-delay 0 --retry-max-time 20 -X GET "https://mainnet-algorand.api.purestake.io/ps2/v2/status"  -H "x-api-key:PURESTAKE-API-KEY" -H 'accept: application/json' | jq -r '."last-round"')

#Adjust MAXROUND since what I get is usually the round currently being set up. I guess I could also sleep for like 10s and it would do the same thing, haven't tried it.

MAXROUND=$(($MAXROUND-5))
#Check if there were any donations between MINDROUND and MAXROUND
curl --connect-timeout 5 --max-time 3 --retry 6 --retry-delay 0 --retry-max-time 20 -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?min-round=${MINROUND}&max-round=${MAXROUND}&currency-greater-than=1999"  -H "x-api-key:PURESTAKE-API-KEY" -H 'accept: application/json' | jq -r '.transactions[] | .sender + " " + (."payment-transaction".amount|tostring)' > /home/algo/donationsv2.txt


#Check if donationsv2.txt is empty. If it is, delete it, it means there weren't any donations.
if [ ! -s /home/algo/donationsv2.txt ]
then
rm /home/algo/donationsv2.txt
fi

#If donationsv2.txt hasn't been deleted for being empty, continue forward. Otherwise the script ends.
if [ -f /home/algo/donationsv2.txt ]
then

## Check how much AFD in the faucet's address just in case it goes under the next threshold and I don't see it.
QTYINFAUCET=$(curl --connect-timeout 5 --max-time 3 --retry 6 --retry-delay 0 --retry-max-time 20 -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/" -H "x-api-key:PURESTAKE-API-KEY" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"393495312"') | .amount')
#Set default RETURN multiplier just in case the verification failed.
RETURN=25000
#Check if the quantity is lower than the next tier. To update every halvening.
#Depending on the quantity, adjust the variable RETURN to the right multiplier
if [ $QTYINFAUCET -gt 6250000000000000 ]
then
RETURN=25000
else
RETURN=12500
fi

#Set increment variable
 i=0

 while IFS= read -r line; do
 donator=$(awk 'NR==1{print$1}' /home/algo/donationsv2.txt)
 don=$(awk 'NR==1{print$2}' /home/algo/donationsv2.txt)
 amount=$(echo $don*$RETURN/1|bc)
 echo "donator $donator - donated $don Algos - returned $amount AFDs" >> /home/algo/logs/log`date +"%Y_%m_%d"`.txt
 goal asset send -a $amount --assetid 393495312 -f FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ -t $donator --note="id=${i} Thank you for your donation!" --fee 1000 --out=/home/algo/tmpdon${i}
 sed -i '1d' /home/algo/donationsv2.txt
 i=$(($i+1))
 done < /home/algo/donationsv2.txt

#rm tmp folder
 rm /home/algo/donationsv2.txt
#build/send transactions
 cat /home/algo/tmpdon* >> /home/algo/unsigned.txn
 goal clerk sign --infile=/home/algo/unsigned.txn --outfile=/home/algo/signed.stxn
 goal clerk rawsend -N -f=/home/algo/signed.stxn
 rm /home/algo/unsigned.txn
 rm /home/algo/signed.stxn
 rm /home/algo/tmpdon*

else

echo "`date +%Y_%m_%d_%H_%M` nothing" >> /home/algo/logs/log`date +"%Y_%m_%d"`.txt

fi

#Add 1 to MAXROUND, store that variable in the MINROUND.txt file for next run
MAXROUND=$(($MAXROUND+1))
printf $MAXROUND > /home/algo/MINROUND.txt

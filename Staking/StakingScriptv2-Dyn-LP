#!/bin/bash

#Tested on Kubuntu 20.04 LTS but should work on basically anything as long as youve got a working node.
#Required optional packages : jq curl bc
#By default the script is in "dry-run" mode. Uncomment the 2x "goal asset send" lines and the last portion of the script to go live.

#Unit Name of the ASA
NAME=AFD

#Asset-id of the ASA
ASA=393495312

#1 Unit of the ASA in microUnits
ASAUNIT=100000000

#Minimum balance of the ASA to hold to qualify, non inclusive. In microUnits. For instance, 1000 AFDs is 100000000000 microUnits because it has 8 decimals.
STAKEMINBAL=99999999999

#Asset-id of the Tinyman LP-Token ASA. No other AMM than Tinyman working right now but script could be adjusted.
POOLASA=552946222

#Minimum amount of the LP-Token ASA to hold to qualify in microUnits, non inclusive. These LP-Tokens have 6 decimals so the value here of 99999 is the equivalent of rewarding people holding 1 Pool token.
POOLMINBAL=999999

# Percent of daily staking in numerical value. In this case 0.2% is 0.002
STAKEDAILY=0.002

#How much MORE as a multiplier of the ASA you want to give out per amount of ASA in Liquidity.
POOLRATIO=1.5

#APIKey on purestake
APIKEY=ObviouslyIWontPutMineHere!

#Notes to attach to each transaction.
STAKENOTE="ASA Staking from TheAlgoFaucet.com"
LPNOTE="LP-Staking from TheAlgoFaucet.com"

#Account on your node which will distribute the rewards
DISTRIBUTER=FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ

#Address of the Tinyman Pool
TINYMANPOOL=OKN6LN3PSSB7H7HXZJ4SQ6YVOYNE6NNXG6TV4TADMFQXYIFRZQXJI5ZATE

#Blacklist addresses. I suggest putting Creator and other dev accounts.
#Leave the 0s in if you won't use all of them otherwise the script will wipe the text file created.
#If you need more than 10, it should be pretty straight forward to add more.
#Algostake 0-1
BLACKLIST0=SSV6SKTMN3IOJO6SWUAT5ERZOBC5K44CQPOH5O7NSXJLGFGU73WUQ7DPGA
BLACKLIST1=4ZK3UPFRJ643ETWSWZ4YJXH3LQTL2FUEI6CIT7HEOVZL6JOECVRMPP34CY
BLACKLIST2=0
BLACKLIST3=0
BLACKLIST4=0
BLACKLIST5=0
BLACKLIST6=0
BLACKLIST7=0
BLACKLIST8=0
BLACKLIST9=0


# Don't touch this.
FOLDER="$NAME"-"$ASA"

# Path you want to use for the ASA. Dont worry about creating them, the script does that right after.
FOLDERPATH=/home/user/${FOLDER}
TMPPATH=/home/user/${FOLDER}/tmp
LOGPATH=/home/user/${FOLDER}/log

##########################################################################################################
#####Shouldnt have to change anything down here except uncomment the goal asset send lines when ready#####
##########################################################################################################

#Creates the paths required, will get commented out by the next sed
mkdir -p $FOLDERPATH
mkdir -p $TMPPATH
mkdir -p $LOGPATH

#Comment out all lines with mkdir inside this script file, including itself.
#This sed was fucking ridiculous to make. It took me fucking 1 hour for this ONE line.
#If your ASA is called mkdir or for some reason you want to put mkdir in your ASA message, you better put it in all caps so it doesn't interfere with this.
#I cannot honestly describe how fucking beautiful this is. This sed also comments ITSELF out after one pass!
#Ridiculous lol.
sed -i '/^[^#]/ s/\(^.*mkdir.*$\)/#\ \1/' $0
#Okay Im done

# curl the Tinyman pool to help calculate the CURRENT swap ratio of ASA to LP-TOKEN
LPTOKENINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$POOLASA"') | .amount')

ASAINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$ASA"') | .amount')


# curl a list of accounts with the minimum balance of the ASA on purestake and format it to a file with ADDRESS AMOUNT. If you want to use another API, change the url.
# Put your API key where required
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${ASA}/balances?currency-greater-than=${STAKEMINBAL}" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/stake.txt"

# curl a list of accounts with the minimum balance of the LP-Token ASA on purestake and format it to a file with ADDRESS AMOUNT. If you want to use another API, change the url.
# Put your API key where required
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${POOLASA}/balances?currency-greater-than=${POOLMINBAL}" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/pool.txt"


# Remove lines with BLACKLIST items for Staking
sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/stake.txt"
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

# Remove lines with BLACKLIST items for Pool
sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/pool.txt"
sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST0}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST1}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST2}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST3}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST4}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST5}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST6}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST7}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST8}/d" "${TMPPATH}/pool.txt"
sed -i "/^${BLACKLIST9}/d" "${TMPPATH}/pool.txt"


# Copy the text file with results in the log folder
cp "${TMPPATH}/stake.txt" "${LOGPATH}/stake-log`date +"%Y%m%d_%H%M"`.txt"

# Create increment variable, start loop reading the text file stake.txt
i=0
while IFS= read -r line; do

# Create TX variables
account=$(awk 'NR==1{print$1}' "${TMPPATH}/stake.txt")
stake=$(awk 'NR==1{print$2}' "${TMPPATH}/stake.txt")
reward=$(echo $stake*$STAKEDAILY/1|bc)

#DRYRUN PART. Creates a text file with what will be sent. I highly suggest you view this file to adjust your version of the script. Comment out when ready for live.
echo STAKE $i $account $reward  >> ${TMPPATH}/dryrun.txt

#BUILD STAKE TRANSACTION. UNCOMMENT BELOW WHEN YOURE READY FOR LIVE
#goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note=" ${STAKENOTE} ${i}" --out="${TMPPATH}/staketmp${i}"

#Delete the current line in the file it's looping
sed -i '1d' "${TMPPATH}/stake.txt"

# Increment the loop
i=$(($i+1))

done < "${TMPPATH}/stake.txt"
rm "${TMPPATH}/stake.txt"
######################################END OF STAKING LOOP########################################

# Copy the text file with results in the log folder
cp "${TMPPATH}/pool.txt" "${LOGPATH}/pool`date +"%Y%m%d_%H%M"`.txt"


LPOUTPOOL=$(echo 18446744073709551615-$LPTOKENINPOOL|bc)
ASAPOOLRATIO=$(echo "scale=6; $LPOUTPOOL*$ASAUNIT/$ASAINPOOL/1000000"|bc)

#Start Loop reading the text file pool.txt
while IFS= read -r line; do

#Create TX variables
account=$(awk 'NR==1{print$1}' "${TMPPATH}/pool.txt")
pool=$(awk 'NR==1{print$2}' "${TMPPATH}/pool.txt")
INLIQUIDITY=$(echo $pool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)
reward=$(echo $INLIQUIDITY*$STAKEDAILY*$POOLRATIO/1|bc)

#DRYRUN PART. Creates a text file with what will be sent. I highly suggest you view this file to adjust your version of the script. Comment out when ready for live.
echo POOL $i $account $reward >> ${TMPPATH}/dryrun.txt


#BUILD LP-Token TRANSACTIONS. UNCOMMENT BELOW WHEN YOURE READY FOR LIVE
#goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note="${LPNOTE} ${i}" --out="${TMPPATH}/staketmp${i}"

#Delete the current line
sed -i '1d' "${TMPPATH}/pool.txt"

# Increment the loop
i=$(($i+1))

done < "${TMPPATH}/pool.txt"

rm "${TMPPATH}/pool.txt"

######################################END of LP-TOKEN LOOP#######################################

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
#goal clerk rawsend --filename=${TMPPATH}/signed.stxn
#sleep 15
#goal clerk rawsend --filename=${TMPPATH}/signed.stxn
#sleep 15
#goal clerk rawsend --filename=${TMPPATH}/signed.stxn
#rm ${TMPPATH}/*

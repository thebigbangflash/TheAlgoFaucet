#Tested on Kubuntu 20.04 LTS but should work on anything basically as long as youve got a working node.
#Required optional packages : jq curl bc


PROJECTNAME=ASDF

#Unit Name of the ASA
NAME=asdf

#Asset-id of the ASA to check for
ASA=123456789

#Minimum balance of the ASA to check in microUnits.
ASAQTY=0

#Notes to attach to each transaction.
NOTE="TheAlgoFaucet.com Clawback for $PROJECTNAME"

#Account on your node which will distribute the rewards
CLAWBACKADD=FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ

#Account to send the clawedback stuff.
CLAWBACKSEND=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

#purestake API key
APIKEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxx

#Blacklist addresses. I suggest putting Creator, Tinyman Pool and other dev accounts.
BLACKLIST0=0
BLACKLIST1=0
BLACKLIST2=0
BLACKLIST3=0
BLACKLIST4=0
BLACKLIST5=0
BLACKLIST6=0
BLACKLIST7=0
BLACKLIST8=0
BLACKLIST9=0


# Don't touch this.
FOLDER="CLAWBACK"-"$NAME"

# Path you want to use for the ASA. Dont worry about creating them, the script does that right after.
FOLDERPATH=/home/user/${FOLDER}
TMPPATH=/home/user/${FOLDER}/tmp
LOGPATH=/home/user/${FOLDER}/log

################FROM HERE ITS ONLY UNCOMMENTING THE TRANSACTION MAKING LINES WITH goal AND THE LAST PORTION WHEN YOURE absolutely READY##########################


#Creates the paths required, will get commented out by the next sed
mkdir -p $FOLDERPATH
mkdir -p $TMPPATH
mkdir -p $LOGPATH
sed -i '/^[^#]/ s/\(^.*mkdir.*$\)/#\ \1/' $0

# curl a list of accounts to clawback
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${ASA}/balances?currency-greater-than=${ASAQTY}" -H "x-api-key:${APIKEY}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/addresses.txt"

# Remove lines with BLACKLIST items for Staking
sed -i "/^${CLAWBACKADD}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${CLAWBACKSEND}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST0}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST1}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST2}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST3}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST4}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST5}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST6}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST7}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST8}/d" "${TMPPATH}/addresses.txt"
sed -i "/^${BLACKLIST9}/d" "${TMPPATH}/addresses.txt"

# Copy the text file with results in the log folder
cp "${TMPPATH}/addresses.txt" "${LOGPATH}/addresses-log`date +"%Y%m%d_%H%M"`.txt"

# Create increment variable, start loop reading the text file stake.txt
i=0
while IFS= read -r line; do

# Create TX variables
account=$(awk 'NR==1{print$1}' "${TMPPATH}/addresses.txt")
inaccount=$(awk 'NR==1{print$2}' "${TMPPATH}/addresses.txt")

#DRYRUN
echo $account $inaccount $i >> ${TMPPATH}/dryrun.txt

#BUILD STAKE TRANSACTION. UNCOMMENT BELOW WHEN YOURE READY FOR LIVE
#goal asset send -a $inaccount --assetid $ASA -f $account -t $CLAWBACKSEND --clawback $CLAWBACKADD --note="${NOTE} ${i}" --out="${TMPPATH}/clawtmp${i}"

#Delete the current line in the file it's looping
sed -i '1d' "${TMPPATH}/addresses.txt"

# Increment the loop
i=$(($i+1))

done < "${TMPPATH}/addresses.txt"
rm "${TMPPATH}/addresses.txt"
######################################END OF CLAWBACK LOOP########################################

######################################PRODUCTION - LIVE ######################################

# Uncomment the lines below once you know youre 100% certain youve got the right results from the dry runs.



#cat ${TMPPATH}/clawtmp* > ${TMPPATH}/unsigned.txn
#goal clerk sign --infile=${TMPPATH}/unsigned.txn --outfile=${TMPPATH}/signed.stxn
#goal clerk rawsend --filename=${TMPPATH}/signed.stxn
#sleep 15
#goal clerk rawsend --filename=${TMPPATH}/signed.stxn
#sleep 15
#goal clerk rawsend --filename=${TMPPATH}/signed.stxn
#rm ${TMPPATH}/*

#!/bin/bash
#Tested on Kubuntu 20.04 LTS but should work on anything basically as long as youve got a working node.
#Required optional packages : jq curl bc

#Unit Name of the ASA
NAME=AFD

#Asset-id of the ASA
ASA=393495312

#1 Unit of the ASA in microUnits
ASAUNIT=100000000

#Minimum balance of the ASA to hold to qualify, non inclusive. In microUnits. For instance, 1000 AFDs is 100000000000 microUnits because it has 8 decimals.
STAKEMINBAL=99999999999

#Address of the Tinyman Pool
TINYMANPOOL=OKN6LN3PSSB7H7HXZJ4SQ6YVOYNE6NNXG6TV4TADMFQXYIFRZQXJI5ZATE
POOLASA=552946222

#Address of the Algofi Pool
ALGOFIPOOL=3VZXIAZZNQUYIUG2HE33UBSIADX4YT6ITBLXIVCU64XLFAO5XYHWDF6PFI
#Asset-id of the Algofi LP-Token ASA
AFPOOLASA=843034037

#Address of the Pactfi Pool
PACTFIPOOL=2NTNLGPB6DKCY2SSMM2GECCQVUQ3N6WJUCTMOOJMNEEX522ZTK7MFKREX4
#Asset-id of the Pactfi LP-Token ASA
PFPOOLASA=843035744

#Address of the Humbleswap Pool
HUMBLEPOOL=CQIOMUYL6BSFQSM7NGTNKBLYDRCU5Y2657M6TXMVB3XLWSVETNAV2R3VWA
#Asset-ID of the Humble LP-Token ASA
HSPOOLASA=843031320

#Minimum amount of the LP-Token ASA to hold to qualify in microUnits, non inclusive. These LP-Tokens have 6 decimals so the value here of 99999 is the equivalent of rewarding people holding 1 Pool token.
POOLMINBAL=999999

# Percent of daily staking in numerical value. In this case 1% is 0.01
STAKEDAILY=0.002

# Percent of daily staking in numerical value. 
POOLDAILY=0.003

# Discord webhook url
WEBHOOK=0
# Coinmarketcap API-key
CMCAPI=0
# Purestake API key
PURESTAKEAPI=0

#Notes to attach to each transaction.
STAKENOTE="TheAlgoFaucet.com $NAME-$NAME"
LPNOTE="TheAlgoFaucet.com $NAME-LP"

#Account on your node which will distribute the rewards
DISTRIBUTER=FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ

#BLACKLIST addresses. Put a space between them.
declare -a BLACKLIST=(SSV6SKTMN3IOJO6SWUAT5ERZOBC5K44CQPOH5O7NSXJLGFGU73WUQ7DPGA 4ZK3UPFRJ643ETWSWZ4YJXH3LQTL2FUEI6CIT7HEOVZL6JOECVRMPP34CY BBFOJHKSWA4SSS7FUFMORM43C2NEYTF2DXFA2N3QTNS5RAFOZSKYQHJZPM FAUC6ZNBAEWCJVJGVDET6BPUPT75WQ6OLA2U3VGHF6HYU5XCYFTXT7JQGY)


# Don't touch this.
FOLDER="$NAME"-"$ASA"

# Path you want to use for the ASA. Dont worry about creating them, the script does that right after.
FOLDERPATH=/home/user/${FOLDER}
TMPPATH=/home/user/${FOLDER}/tmp
LOGPATH=/home/user/${FOLDER}/log

################FROM HERE ITS BASICALLY ONLY UNCOMMENTING PRODUCTION/LIVE WHEN YOURE READY##########################
i=0

#Creates the paths required, will get commented out by the next sed
mkdir -p $FOLDERPATH
mkdir -p $TMPPATH
mkdir -p $LOGPATH
sed -i '/^[^#]/ s/\(^.*mkdir.*$\)/#\ \1/' $0

#Clean up just in case some garbage is still left
rm ${TMPPATH}/*

# curl Algo price from CMC
ALGOPRICE=$(curl -H "X-CMC_PRO_API_KEY: $CMCAPI" -H "Accept: application/json" -G https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=ALGO | jq -r .data.ALGO[].quote.USD.price)

###########REGULAR STAKING#################
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${ASA}/balances?currency-greater-than=${STAKEMINBAL}&limit=10000" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/stake.txt"
###########################################

###########TINYMAN POOL####################
LPTOKENINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$POOLASA"') | .amount')
ASAINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$ASA"') | .amount')
ALGOINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r .account.amount)
SWAPRATIO=$(echo "scale=10; $ALGOINPOOL*$ASAUNIT/$ASAINPOOL/1000000" | bc)
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${POOLASA}/balances?currency-greater-than=${POOLMINBAL}&limit=10000" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/pool.txt"
###########################################

###########ALGOFI POOL#####################
AFLPTOKENINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${ALGOFIPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$AFPOOLASA"') | .amount')
AFASAINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${ALGOFIPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$ASA"') | .amount')
AFALGOINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${ALGOFIPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r .account.amount)
AFSWAPRATIO=$(echo "scale=10; $AFALGOINPOOL*$ASAUNIT/$AFASAINPOOL/1000000" | bc)
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${AFPOOLASA}/balances?currency-greater-than=${POOLMINBAL}&limit=10000" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/afpool.txt"
###########################################

###########PACTFI POOL#####################
PFLPTOKENINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${PACTFIPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$PFPOOLASA"') | .amount')
PFASAINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${PACTFIPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$ASA"') | .amount')
PFALGOINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${PACTFIPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r .account.amount)
PFSWAPRATIO=$(echo "scale=10; $PFALGOINPOOL*$ASAUNIT/$PFASAINPOOL/1000000" | bc)
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${PFPOOLASA}/balances?currency-greater-than=${POOLMINBAL}&limit=10000" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/pfpool.txt"
###########################################

###########HUMBLESWAP POOL#####################
HSLPTOKENINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${HUMBLEPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$HSPOOLASA"') | .amount')
HSASAINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${HUMBLEPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$ASA"') | .amount')
HSALGOINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${HUMBLEPOOL}/" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r .account.amount)
HSSWAPRATIO=$(echo "scale=10; $HSALGOINPOOL*$ASAUNIT/$HSASAINPOOL/1000000" | bc)
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${HSPOOLASA}/balances?currency-greater-than=${POOLMINBAL}&limit=10000" -H "x-api-key:${PURESTAKEAPI}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/hspool.txt"
###########################################

if [ -f "${TMPPATH}/stake.txt" ]; then
  for black in "${BLACKLIST[@]}"
  do
    sed -i "/^${black}/d" "${TMPPATH}/stake.txt"
done
fi

if [ -f "${TMPPATH}/pool.txt" ]; then
  for black in "${BLACKLIST[@]}"
  do
    sed -i "/^${black}/d" "${TMPPATH}/pool.txt"
done
fi

if [ -f "${TMPPATH}/afpool.txt" ]; then
  for black in "${BLACKLIST[@]}"
  do
    sed -i "/^${black}/d" "${TMPPATH}/afpool.txt"
done
fi

if [ -f "${TMPPATH}/pfpool.txt" ]; then
  for black in "${BLACKLIST[@]}"
  do
    sed -i "/^${black}/d" "${TMPPATH}/pfpool.txt"
done
fi

if [ -f "${TMPPATH}/hspool.txt" ]; then
  for black in "${BLACKLIST[@]}"
  do
    sed -i "/^${black}/d" "${TMPPATH}/hspool.txt"
done
fi

# Remove lines with BLACKLIST items for Staking
if [ -f "${TMPPATH}/stake.txt" ]; then
  sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/stake.txt"
  sed -i "/^${ALGOFIPOOL}/d" "${TMPPATH}/stake.txt"
  sed -i "/^${HUMBLEPOOL}/d" "${TMPPATH}/stake.txt"
  sed -i "/^${PACTFIPOOL}/d" "${TMPPATH}/stake.txt"
  sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/stake.txt"
fi

# Remove lines with BLACKLIST items for Pool
if [ -f "${TMPPATH}/pool.txt" ]; then
  sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/pool.txt"
  sed -i "/^${ALGOFIPOOL}/d" "${TMPPATH}/pool.txt"
  sed -i "/^${HUMBLEPOOL}/d" "${TMPPATH}/pool.txt"
  sed -i "/^${PACTFIPOOL}/d" "${TMPPATH}/pool.txt"
  sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/pool.txt"
fi

# Remove lines with BLACKLIST items for Pool
if [ -f "${TMPPATH}/afpool.txt" ]; then
  sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/afpool.txt"
  sed -i "/^${ALGOFIPOOL}/d" "${TMPPATH}/afpool.txt"
  sed -i "/^${HUMBLEPOOL}/d" "${TMPPATH}/afpool.txt"
  sed -i "/^${PACTFIPOOL}/d" "${TMPPATH}/afpool.txt"
  sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/afpool.txt"
fi

# Remove lines with BLACKLIST items for pactfi Pool
if [ -f "${TMPPATH}/pfpool.txt" ]; then
  sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/pfpool.txt"
  sed -i "/^${ALGOFIPOOL}/d" "${TMPPATH}/pfpool.txt"
  sed -i "/^${HUMBLEPOOL}/d" "${TMPPATH}/pfpool.txt"
  sed -i "/^${PACTFIPOOL}/d" "${TMPPATH}/pfpool.txt"
  sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/pfpool.txt"
fi

# Remove lines with BLACKLIST items for Humble Pool
if [ -f "${TMPPATH}/hspool.txt" ]; then
  sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/hspool.txt"
  sed -i "/^${ALGOFIPOOL}/d" "${TMPPATH}/hspool.txt"
  sed -i "/^${HUMBLEPOOL}/d" "${TMPPATH}/hspool.txt"
  sed -i "/^${PACTFIPOOL}/d" "${TMPPATH}/hspool.txt"
  sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/hspool.txt"
fi


###############################START STAKING LOOP###############################################
if [ -f "${TMPPATH}/stake.txt" ]; then
# Copy the text file with results in the log folder
cp "${TMPPATH}/stake.txt" "${LOGPATH}/stake-log`date +"%Y%m%d_%H%M"`.txt"

# Start loop reading the text file stake.txt

while IFS= read -r line; do

# Create TX variables
  account=$(awk 'NR==1{print$1}' "${TMPPATH}/stake.txt")
  stake=$(awk 'NR==1{print$2}' "${TMPPATH}/stake.txt")
  reward=$(echo $stake*$STAKEDAILY/1|bc)
  REWARDPRICE=$(echo "scale=6; $reward*$SWAPRATIO*$ALGOPRICE/$ASAUNIT" | bc)

  echo STAKE $account $reward $i $REWARDPRICE USD >> ${TMPPATH}/dryrun.txt

  #BUILD STAKE TRANSACTION.
  goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note="${STAKENOTE} sid=${i} currentvalue=${REWARDPRICE} USD" --out="${TMPPATH}/staketmp${i}"

  #Delete the current line in the file it's looping
  sed -i '1d' "${TMPPATH}/stake.txt"

  # Increment the loop
  i=$(($i+1))

  done < "${TMPPATH}/stake.txt"
rm "${TMPPATH}/stake.txt"
fi
######################################END OF STAKING LOOP########################################
if [ -f "${TMPPATH}/pool.txt" ]; then
# Copy the text file with results in the log folder
cp "${TMPPATH}/pool.txt" "${LOGPATH}/pool`date +"%Y%m%d_%H%M"`.txt"

LPOUTPOOL=$(echo 18446744073709551615-$LPTOKENINPOOL|bc)
ASAPOOLRATIO=$(echo "scale=10; $LPOUTPOOL*$ASAUNIT/$ASAINPOOL/1000000"|bc)

#Start Loop
while IFS= read -r line; do

  #Create TX variables
  account=$(awk 'NR==1{print$1}' "${TMPPATH}/pool.txt")
  pool=$(awk 'NR==1{print$2}' "${TMPPATH}/pool.txt")
  INLIQUIDITY=$(echo $pool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)
  reward=$(echo $INLIQUIDITY*$POOLDAILY/1|bc)
  REWARDPRICE=$(echo "scale=6; $reward*$SWAPRATIO*$ALGOPRICE/$ASAUNIT" | bc)

  echo TINYPOOL $account $reward $i $REWARDPRICE USD >> ${TMPPATH}/dryrun.txt

  #BUILD LP-Token TRANSACTIONS.
  goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note="${LPNOTE} pid=${i} currentvalue=${REWARDPRICE} USD" --out="${TMPPATH}/staketmp${i}"

  #Delete the current line
  sed -i '1d' "${TMPPATH}/pool.txt"

  # Increment the loop
  i=$(($i+1))

done < "${TMPPATH}/pool.txt"

rm "${TMPPATH}/pool.txt"
fi
######################################END of LP-TOKEN LOOP#######################################
######################################START OF ALGOFI LOOP#######################################
if [ -f "${TMPPATH}/afpool.txt" ]; then
# Copy the text file with results in the log folder
cp "${TMPPATH}/afpool.txt" "${LOGPATH}/afpool`date +"%Y%m%d_%H%M"`.txt"

AFLPOUTPOOL=$(echo 18446744073709551615-$AFLPTOKENINPOOL|bc)
AFASAPOOLRATIO=$(echo "scale=10; $AFLPOUTPOOL*$ASAUNIT/$AFASAINPOOL/1000000"|bc)

#Start Loop
while IFS= read -r line; do

  #Create TX variables
  account=$(awk 'NR==1{print$1}' "${TMPPATH}/afpool.txt")
  pool=$(awk 'NR==1{print$2}' "${TMPPATH}/afpool.txt")
  AFINLIQUIDITY=$(echo $pool/$AFASAPOOLRATIO*$ASAUNIT/1000000|bc)
  reward=$(echo $AFINLIQUIDITY*$POOLDAILY/1|bc)
  REWARDPRICE=$(echo "scale=6; $reward*$AFSWAPRATIO*$ALGOPRICE/$ASAUNIT" | bc)

  #DRYRUN
  echo AFPOOL $account $reward $i $REWARDPRICE USD >> ${TMPPATH}/dryrun.txt

  #BUILD LP-Token txs
  goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note="${LPNOTE} pid=${i} currentvalue=${REWARDPRICE} USD" --out="${TMPPATH}/staketmp${i}"

  #Delete the current line
  sed -i '1d' "${TMPPATH}/afpool.txt"

  # Increment the loop
  i=$(($i+1))

done < "${TMPPATH}/afpool.txt"

rm "${TMPPATH}/afpool.txt"
fi
######################################END of ALGOFI LOOP#######################################
######################################START OF PACTFI LOOP#######################################
if [ -f "${TMPPATH}/pfpool.txt" ]; then
# Copy the text file with results in the log folder
cp "${TMPPATH}/pfpool.txt" "${LOGPATH}/pfpool`date +"%Y%m%d_%H%M"`.txt"

PFLPOUTPOOL=$(echo 18446744073709551615-$PFLPTOKENINPOOL|bc)
PFASAPOOLRATIO=$(echo "scale=10; $PFLPOUTPOOL*$ASAUNIT/$PFASAINPOOL/1000000"|bc)

#Start Loop
while IFS= read -r line; do

  #Create TX variables
  account=$(awk 'NR==1{print$1}' "${TMPPATH}/pfpool.txt")
  pool=$(awk 'NR==1{print$2}' "${TMPPATH}/pfpool.txt")
  PFINLIQUIDITY=$(echo $pool/$PFASAPOOLRATIO*$ASAUNIT/1000000|bc)
  reward=$(echo $PFINLIQUIDITY*$POOLDAILY/1|bc)
  REWARDPRICE=$(echo "scale=6; $reward*$PFSWAPRATIO*$ALGOPRICE/$ASAUNIT" | bc)

  echo PFPOOL $account $reward $i $REWARDPRICE USD >> ${TMPPATH}/dryrun.txt

  #BUILD LP-Token txs
  goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note="${LPNOTE} pid=${i} currentvalue=${REWARDPRICE} USD" --out="${TMPPATH}/staketmp${i}"

  #Delete the current line
  sed -i '1d' "${TMPPATH}/pfpool.txt"

  ## Increment the loop
  i=$(($i+1))

done < "${TMPPATH}/pfpool.txt"

rm "${TMPPATH}/pfpool.txt"
fi
######################################END of PACTFI LOOP#######################################
######################################START OF HUMBLESWAP LOOP#######################################
if [ -f "${TMPPATH}/hspool.txt" ]; then
# Copy the text file with results in the log folder
cp "${TMPPATH}/hspool.txt" "${LOGPATH}/hspool`date +"%Y%m%d_%H%M"`.txt"

HSLPOUTPOOL=$(echo 18446744073709551615-$HSLPTOKENINPOOL|bc)
HSASAPOOLRATIO=$(echo "scale=10; $HSLPOUTPOOL*$ASAUNIT/$HSASAINPOOL/1000000"|bc)

#Start Loop
while IFS= read -r line; do

  #Create TX variables
  account=$(awk 'NR==1{print$1}' "${TMPPATH}/hspool.txt")
  pool=$(awk 'NR==1{print$2}' "${TMPPATH}/hspool.txt")
  HSINLIQUIDITY=$(echo $pool/$HSASAPOOLRATIO*$ASAUNIT/1000000|bc)
  reward=$(echo $HSINLIQUIDITY*$POOLDAILY/1|bc)
  REWARDPRICE=$(echo "scale=6; $reward*$HSSWAPRATIO*$ALGOPRICE/$ASAUNIT" | bc)

  echo HSPOOL $account $reward $i $REWARDPRICE USD >> ${TMPPATH}/dryrun.txt

  #BUILD LP-Token txs
  goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note="${LPNOTE} pid=${i} currentvalue=${REWARDPRICE} USD" --out="${TMPPATH}/staketmp${i}"

  #Delete the current line
  sed -i '1d' "${TMPPATH}/hspool.txt"

  # Increment the loop
  i=$(($i+1))

done < "${TMPPATH}/hspool.txt"

rm "${TMPPATH}/hspool.txt"
fi
######################################END ofHUMBLESWAP LOOP#######################################

######################################PRODUCTION - LIVE ######################################
# Uncomment the lines below once you know youre 100% certain youve got the right results from the dry runs.

#cat ${TMPPATH}/staketmp* > ${TMPPATH}/unsigned.txn
#goal clerk sign --infile=${TMPPATH}/unsigned.txn --outfile=${TMPPATH}/signed.stxn
#goal clerk rawsend -N --filename=${TMPPATH}/signed.stxn
#sleep 15
#goal clerk rawsend -N --filename=${TMPPATH}/signed.stxn
#sleep 15
#goal clerk rawsend -N --filename=${TMPPATH}/signed.stxn

######################################PRODUCTION - LIVE ######################################


###### STATS ##################
totaltmp=$(awk '{print$3}' "${TMPPATH}/dryrun.txt" | paste -sd+ | bc)
numberofchars=$(echo $ASAUNIT | wc -c)
numberofzeroes=$(echo "$numberofchars-2" | bc)
total=$(echo "scale=$numberofzeroes ; $totaltmp/$ASAUNIT" | bc)
totalregulartmp=$(cat "${TMPPATH}/dryrun.txt" | grep STAKE| awk '{print$3}'  | paste -sd+ | bc)
totalregular=$(echo "scale=$numberofzeroes; $totalregulartmp/$ASAUNIT" | bc)
totaltinymantmp=$(cat "${TMPPATH}/dryrun.txt" | grep TINYPOOL | awk '{print$3}' |  paste -sd+ | bc)
totaltinyman=$(echo "scale=$numberofzeroes; $totaltinymantmp/$ASAUNIT" | bc)
totalalgofitmp=$(cat "${TMPPATH}/dryrun.txt" | grep AFPOOL | awk '{print$3}' |  paste -sd+ | bc)
totalalgofi=$(echo "scale=$numberofzeroes; $totalalgofitmp/$ASAUNIT" | bc)
totalpactfitmp=$(cat "${TMPPATH}/dryrun.txt" | grep PFPOOL | awk '{print$3}' |  paste -sd+ | bc)
totalpactfi=$(echo "scale=$numberofzeroes; $totalalgofitmp/$ASAUNIT" | bc)
totalhumbletmp=$(cat "${TMPPATH}/dryrun.txt" | grep HSPOOL | awk '{print$3}' |  paste -sd+ | bc)
totalhumble=$(echo "scale=$numberofzeroes; $totalhumbletmp/$ASAUNIT" | bc)
regularstaking=$(cat "${TMPPATH}/dryrun.txt" | awk '{print$1}' | grep STAKE | wc | awk '{print$1}')
tinymanstaking=$(cat "${TMPPATH}/dryrun.txt" | awk '{print$1}' | grep TINYPOOL | wc | awk '{print$1}')
algofistaking=$(cat "${TMPPATH}/dryrun.txt" | awk '{print$1}' | grep AFPOOL | wc | awk '{print$1}')
pactfistaking=$(cat "${TMPPATH}/dryrun.txt" | awk '{print$1}' | grep PFPOOL | wc | awk '{print$1}')
humblestaking=$(cat "${TMPPATH}/dryrun.txt" | awk '{print$1}' | grep HSPOOL | wc | awk '{print$1}')
printf "\nstats:\n$i addresses\n$total of ASA-$ASA\n\nDistributed this way\n$regularstaking REGULAR STAKING\n$tinymanstaking TINYMAN POOL\n$algofistaking ALGOFI POOL\n$pactfistaking PACTFI POOL\n$humblestaking HUMBLESWAP POOL\nRAW DATA :\n\n TYPE  ADDRESS  QUANTITY  ID  VALUE  UNIT\n" >> "${LOGPATH}/stats`date +"%Y_%m_%d"`.txt"
cat "${TMPPATH}/dryrun.txt" >> "${LOGPATH}/stats`date +"%Y_%m_%d"`.txt"

#create function for discord curl POST
generate_post_data()
{
  cat <<EOF
{"content":"Stats from TheAlgoFaucet.com:\n$NAME distributed to a total of $i addresses\n$total $NAME distributed today!\n\nDistributed this way\n\n$regularstaking addresses for AFD-AFD staking for a total of $totalregular $NAME\n$tinymanstaking addresses for Tinyman $NAME-ALGO staking for a total of $totaltinyman $NAME\n$algofistaking addresses for Algofi $NAME-ALGO staking for a total of $totalalgofi $NAME\n$pactfistaking addresses for Pactfi $NAME-ALGO staking for a total of $totalpactfi $NAME\n$humblestaking addresses for HumbleSwap $NAME-ALGO staking for a total of $totalhumble $NAME"}
EOF
}


# Post to discord
curl -v \
-H "Content-Type: application/json" \
POST \
-d "$(generate_post_data)" \
"$WEBHOOK"

rm ${TMPPATH}/*

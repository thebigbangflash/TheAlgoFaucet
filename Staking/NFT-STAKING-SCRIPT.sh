#!/bin/bash
#Current version of NFT-OGS script on May 3rd 2022. Erase whatever and fill in your values.
#Sorry for people reading the loops, I use single letter variables for a bunch of stuff.

#Tested on Kubuntu 20.04 LTS but should work on anything basically as long as youve got a working node.
#Required optional packages : jq curl bc

#NFT Project Name
NAME=NFT-OGS

#Purestake API key
purestakeapi=aaaaaaaaaaaaaaaaaaaaaaaaaaa
#CoinMarketCap API key
cmcapi=aaaaaaaaaaaaaaaaaaaaaa

# NFT Tiers, fill between the parentheses with a space between each NFT
# TIER0 is the most exclusive one and the higher the number the more common the NFT
# If you need to add NFT Tiers, simply add other "declare -a TIER10=()", "declare -a TIER11=()" and so forth.
# Then add the corresponding quantites to send underneath
# No need to add anything else.
#1/10
declare -a TIER0=(704805852)
#1/25
declare -a TIER1=(696367294 697586682 706856671 715026524)
#1/50
declare -a TIER2=(706856016 715026165)
#1/75
declare -a TIER3=(696368395 704804994)
#1/100
declare -a TIER4=(704804185 715025663)
#1/150
declare -a TIER5=(696367854 704805521 715025031)
#1/175
declare -a TIER6=(697586186)
#1/250
declare -a TIER7=(704804574)
declare -a TIER8=()
declare -a TIER9=()

# Quantities to send of the ASA per tier in microUnits. Leftmost is Tier0, then Tier1, then Tier2 and so forth.
# Put a space between each one. Each tier HAS TO HAVE A CORRESPONDING AMOUNT SENT!
ASATIERS=(833333333 333333333 166666666 111111111 83333333 55555555 47619047 33333333)

# ASA to send
ASA=613608234

# 1 unit of the ASA in microUnits
ASAUNIT=1000000000

#Notes to attach to each transaction.
NFTNOTE="TheAlgoFaucet.com NFT Staking"

#Account on your node which will distribute the rewards
DISTRIBUTER=FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ

#Address of the Tinyman Pool for the ASA. Mainly used to calculate USD rewards.
TINYMANPOOL=EXZTTSDQMKODAUGJSQ7SISZK45LYEL7CKU4Q6DYUAJC7AFTMQ3FU4LIR7M

#Blacklist addresses. I suggest putting Creator, Reserve and other dev accounts. There could be a way for me to check "creator account" for each NFT, but at this point, might as well enter them manually.

BLACKLIST0=UKIPJHMYR4ARN2MORAJ7OW2YPM2LJTHBLQZBBL62GCPQR2D7N7FEX52FVQ
BLACKLIST1=OGSSSQBRWFGB7FPYWBHI3S7VOI3YOGPVAAGLLER4YCC2QXQWDSNRKLZQDE
BLACKLIST2=0
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
mkdir -p $FOLDERPATH
mkdir -p $TMPPATH
mkdir -p $LOGPATH

#Comment out all lines with mkdir inside this script file, including itself.
#This sed was fucking ridiculous to make. It took me fucking 1 hour for this ONE line.
#If your ASA is called mkdir or for some reason you want to put mkdir in your ASA message, you better put it in all caps so it doesn't interfere with this.
#I cannot honestly describe how fucking beautiful this is. This sed comments ITSELF out after one pass!
#Ridiculous lol.
sed -i '/^[^#]/ s/\(^.*mkdir.*$\)/#\ \1/' $0
#Okay I m done

#Get values to calculate USD and Swap Ratio
ASAINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${purestakeapi}" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"$ASA"') | .amount')
# curl Algo price from CMC
ALGOPRICE=$(curl -H "X-CMC_PRO_API_KEY: ${cmcapi}" -H "Accept: application/json" -G https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=ALGO | jq -r .data.ALGO[].quote.USD.price)
# curl amount of Algo in pool
ALGOINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${TINYMANPOOL}/" -H "x-api-key:${purestakeapi}" -H 'accept: application/json' | jq -r .account.amount)
#calculate the swap ratio between ALGO and ASA
SWAPRATIO=$(echo "scale=6; $ALGOINPOOL*$ASAUNIT/$ASAINPOOL/1000000" | bc)


#NUMBER OF TIERS
a=$(echo ${#ASATIERS[@]})
################ TIERS API query######################
s=0
while [ $s -lt $a ]
do
  n="TIER$s[@]"
  arr=("${!n}")
  for (( k = 0 ; k < ${#arr[@]} ; k++ ))
  do
#  echo "NFT ${arr[$k]}"
  curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/assets/${arr[$k]}/balances?currency-greater-than=0" -H "x-api-key:${purestakeapi}" -H 'accept: application/json' | jq -r '.balances[] | .address + " " + (.amount|tostring)' >> "${TMPPATH}/tier${s}.txt"
  sleep 0.1s
  done
s=$(($s+1))
done
#######################################################

# Remove lines with BLACKLIST item from all tiers######
s=0
while [ $s -lt $a ]
do
sed -i "/^${TINYMANPOOL}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${DISTRIBUTER}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST0}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST1}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST2}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST3}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST4}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST5}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST6}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST7}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST8}/d" "${TMPPATH}/tier${s}.txt"
sed -i "/^${BLACKLIST9}/d" "${TMPPATH}/tier${s}.txt"
s=$(($s+1))
done
#######################################################

# Copy stuff into logs folder
l=0
while [ $l -lt $a ]
do
cp "${TMPPATH}/tier${l}.txt" "${LOGPATH}/tier${l}`date +"%Y%m%d_%H%M"`.txt"
l=$(($l+1))
done

# Create increment variable, start loops!
i=0

################### START LOOP ###########################
t=0

while [ $t -lt $a ]
do
  while IFS= read -r line; do
  # Create TX variables
  account=$(awk 'NR==1{print$1}' "${TMPPATH}/tier${t}.txt")
  stake=$(awk 'NR==1{print$2}' "${TMPPATH}/tier${t}.txt")
  reward=$(echo $stake*${ASATIERS[$t]}|bc)
  REWARDPRICE=$(echo "scale=6; $reward*$SWAPRATIO*$ALGOPRICE/$ASAUNIT" | bc)

  #DryRun
  echo tier$t $account $reward $i $REWARDPRICE USD >> ${TMPPATH}/dryrun.txt

  #BUILD TX. Uncomment when ready for prod.
  #goal asset send --from=$DISTRIBUTER --assetid=$ASA --to=$account --fee=1000 --amount=$reward --note="${NFTNOTE} tier=${t} id=${i} currentvalue=${REWARDPRICE} USD" --out="${TMPPATH}/staketmp${i}"

  #Delete the current line in the file it's looping
  sed -i '1d' "${TMPPATH}/tier${t}.txt"

  # Increment the loop
  i=$(($i+1))

  done < "${TMPPATH}/tier${t}.txt"
  rm "${TMPPATH}/tier${t}.txt"
t=$(($t+1))
done

################### END LOOP ##############################

# Gather some stats, for people who like that kind of stuff.#############

total=$(awk '{print$3}' "${TMPPATH}/dryrun.txt" | paste -sd+ | bc)
printf "\nstats:\n$i addresses\n$total $NAME-$ASA\n" >> "${TMPPATH}/dryrun.txt"
cp "${TMPPATH}/dryrun.txt" "${LOGPATH}/send`date +"%Y%m%d_%H%M"`.txt"




#############################################################################################
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

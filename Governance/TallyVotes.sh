ASAUNIT=100000000

# curl the Tinyman pool to help calculate the CURRENT swap ratio of ASA to LP-TOKEN
LPTOKENINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/OKN6LN3PSSB7H7HXZJ4SQ6YVOYNE6NNXG6TV4TADMFQXYIFRZQXJI5ZATE/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"552946222"') | .amount')

ASAINPOOL=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/OKN6LN3PSSB7H7HXZJ4SQ6YVOYNE6NNXG6TV4TADMFQXYIFRZQXJI5ZATE/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"=='"393495312"') | .amount')

LPOUTPOOL=$(echo 18446744073709551615-$LPTOKENINPOOL|bc)
ASAPOOLRATIO=$(echo "scale=6; $LPOUTPOOL*$ASAUNIT/$ASAINPOOL/1000000"|bc)

#########################################Gov1:A########################################
cp /home/k/gov/Gov1-A.txt /home/k/gov/Gov1-A.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov1-A-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov1-A-tally.txt

sed -i '1d' "/home/k/gov/Gov1-A.bak"

done < "/home/k/gov/Gov1-A.bak"
rm "/home/k/gov/Gov1-A.bak"


#########################################Gov1:B########################################
cp /home/k/gov/Gov1-B.txt /home/k/gov/Gov1-B.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov1-B-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov1-B-tally.txt

sed -i '1d' "/home/k/gov/Gov1-B.bak"

done < "/home/k/gov/Gov1-B.bak"
rm "/home/k/gov/Gov1-B.bak"

#########################################Gov2:A########################################
cp /home/k/gov/Gov2-A.txt /home/k/gov/Gov2-A.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov2-A-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov2-A-tally.txt

sed -i '1d' "/home/k/gov/Gov2-A.bak"

done < "/home/k/gov/Gov2-A.bak"
rm "/home/k/gov/Gov2-A.bak"
#########################################Gov2:B########################################
cp /home/k/gov/Gov2-B.txt /home/k/gov/Gov2-B.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov2-B-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov2-B-tally.txt

sed -i '1d' "/home/k/gov/Gov2-B.bak"

done < "/home/k/gov/Gov2-B.bak"
rm "/home/k/gov/Gov2-B.bak"
#########################################Gov2:C########################################
cp /home/k/gov/Gov2-C.txt /home/k/gov/Gov2-C.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov2-C-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov2-C-tally.txt

sed -i '1d' "/home/k/gov/Gov2-C.bak"

done < "/home/k/gov/Gov2-C.bak"
rm "/home/k/gov/Gov2-C.bak"
#########################################Gov3:A########################################
cp /home/k/gov/Gov3-A.txt /home/k/gov/Gov3-A.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov3-A-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov3-A-tally.txt

sed -i '1d' "/home/k/gov/Gov3-A.bak"

done < "/home/k/gov/Gov3-A.bak"
rm "/home/k/gov/Gov3-A.bak"
#########################################Gov3:B########################################
cp /home/k/gov/Gov3-B.txt /home/k/gov/Gov3-B.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov3-B-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov3-B-tally.txt

sed -i '1d' "/home/k/gov/Gov3-B.bak"

done < "/home/k/gov/Gov3-B.bak"
rm "/home/k/gov/Gov3-B.bak"
#########################################Gov4:A########################################
cp /home/k/gov/Gov4-A.txt /home/k/gov/Gov4-A.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov4-A-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov4-A-tally.txt

sed -i '1d' "/home/k/gov/Gov4-A.bak"

done < "/home/k/gov/Gov4-A.bak"
rm "/home/k/gov/Gov4-A.bak"
#########################################Gov4:B########################################
cp /home/k/gov/Gov4-B.txt /home/k/gov/Gov4-B.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov4-B-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov4-B-tally.txt

sed -i '1d' "/home/k/gov/Gov4-B.bak"

done < "/home/k/gov/Gov4-B.bak"
rm "/home/k/gov/Gov4-B.bak"
#########################################Gov4:C########################################
cp /home/k/gov/Gov4-C.txt /home/k/gov/Gov4-C.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov4-C-tally.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

INLIQUIDITY=$(echo $resultpool/$ASAPOOLRATIO*$ASAUNIT/1000000|bc)

echo $line $INLIQUIDITY >> /home/k/gov/results/Gov4-C-tally.txt

sed -i '1d' "/home/k/gov/Gov4-C.bak"

done < "/home/k/gov/Gov4-C.bak"
rm "/home/k/gov/Gov4-C.bak"

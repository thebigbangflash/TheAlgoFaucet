#########################################Gov1:A########################################
cp /home/k/gov/Gov1-A.txt /home/k/gov/Gov1-A.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov1-A-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov1-A-POOL.txt

sed -i '1d' "/home/k/gov/Gov1-A.bak"

done < "/home/k/gov/Gov1-A.bak"
rm "/home/k/gov/Gov1-A.bak"


#########################################Gov1:B########################################
cp /home/k/gov/Gov1-B.txt /home/k/gov/Gov1-B.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov1-B-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov1-B-POOL.txt

sed -i '1d' "/home/k/gov/Gov1-B.bak"

done < "/home/k/gov/Gov1-B.bak"
rm "/home/k/gov/Gov1-B.bak"

#########################################Gov2:A########################################
cp /home/k/gov/Gov2-A.txt /home/k/gov/Gov2-A.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov2-A-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov2-A-POOL.txt

sed -i '1d' "/home/k/gov/Gov2-A.bak"

done < "/home/k/gov/Gov2-A.bak"
rm "/home/k/gov/Gov2-A.bak"
#########################################Gov2:B########################################
cp /home/k/gov/Gov2-B.txt /home/k/gov/Gov2-B.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov2-B-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov2-B-POOL.txt

sed -i '1d' "/home/k/gov/Gov2-B.bak"

done < "/home/k/gov/Gov2-B.bak"
rm "/home/k/gov/Gov2-B.bak"
#########################################Gov2:C########################################
cp /home/k/gov/Gov2-C.txt /home/k/gov/Gov2-C.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov2-C-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov2-C-POOL.txt

sed -i '1d' "/home/k/gov/Gov2-C.bak"

done < "/home/k/gov/Gov2-C.bak"
rm "/home/k/gov/Gov2-C.bak"
#########################################Gov3:A########################################
cp /home/k/gov/Gov3-A.txt /home/k/gov/Gov3-A.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov3-A-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov3-A-POOL.txt

sed -i '1d' "/home/k/gov/Gov3-A.bak"

done < "/home/k/gov/Gov3-A.bak"
rm "/home/k/gov/Gov3-A.bak"
#########################################Gov3:B########################################
cp /home/k/gov/Gov3-B.txt /home/k/gov/Gov3-B.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov3-B-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov3-B-POOL.txt

sed -i '1d' "/home/k/gov/Gov3-B.bak"

done < "/home/k/gov/Gov3-B.bak"
rm "/home/k/gov/Gov3-B.bak"
#########################################Gov4:A########################################
cp /home/k/gov/Gov4-A.txt /home/k/gov/Gov4-A.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov4-A-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov4-A-POOL.txt

sed -i '1d' "/home/k/gov/Gov4-A.bak"

done < "/home/k/gov/Gov4-A.bak"
rm "/home/k/gov/Gov4-A.bak"
#########################################Gov4:B########################################
cp /home/k/gov/Gov4-B.txt /home/k/gov/Gov4-B.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov4-B-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov4-B-POOL.txt

sed -i '1d' "/home/k/gov/Gov4-B.bak"

done < "/home/k/gov/Gov4-B.bak"
rm "/home/k/gov/Gov4-B.bak"
#########################################Gov4:C########################################
cp /home/k/gov/Gov4-C.txt /home/k/gov/Gov4-C.bak

while IFS= read -r line; do
resultafd=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==393495312) | .amount')

echo $line $resultafd >> /home/k/gov/results/Gov4-C-AFD.txt

resultpool=$(curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/${line}/" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.account.assets[] | select (."asset-id"==552946222) | .amount')

echo $line $resultpool >> /home/k/gov/results/Gov4-C-POOL.txt

sed -i '1d' "/home/k/gov/Gov4-C.bak"

done < "/home/k/gov/Gov4-C.bak"
rm "/home/k/gov/Gov4-C.bak"

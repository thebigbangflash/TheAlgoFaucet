#Gov1:A
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292MTpB" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov1-Atmp.txt

sort -uf /home/k/gov/Gov1-Atmp.txt > /home/k/gov/Gov1-A.txt
rm /home/k/gov/Gov1-Atmp.txt

#Gov1:B
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292MTpC" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov1-Btmp.txt

sort -uf /home/k/gov/Gov1-Btmp.txt > /home/k/gov/Gov1-B.txt
rm /home/k/gov/Gov1-Btmp.txt

#Gov2:A
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292MjpB" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov2-Atmp.txt

sort -uf /home/k/gov/Gov2-Atmp.txt > /home/k/gov/Gov2-A.txt
rm /home/k/gov/Gov2-Atmp.txt

#Gov2:B
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292MjpC" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov2-Btmp.txt

sort -uf /home/k/gov/Gov2-Btmp.txt > /home/k/gov/Gov2-B.txt
rm /home/k/gov/Gov2-Btmp.txt

#Gov2:C
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292MjpD" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov2-Ctmp.txt

sort -uf /home/k/gov/Gov2-Ctmp.txt > /home/k/gov/Gov2-C.txt
rm /home/k/gov/Gov2-Ctmp.txt

#Gov3:A
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292MzpB" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov3-Atmp.txt

sort -uf /home/k/gov/Gov3-Atmp.txt > /home/k/gov/Gov3-A.txt
rm /home/k/gov/Gov3-Atmp.txt

#Gov3:B
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292MzpC" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov3-Btmp.txt

sort -uf /home/k/gov/Gov3-Btmp.txt > /home/k/gov/Gov3-B.txt
rm /home/k/gov/Gov3-Btmp.txt

#Gov4:A
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292NDpB" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov4-Atmp.txt

sort -uf /home/k/gov/Gov4-Atmp.txt > /home/k/gov/Gov4-A.txt
rm /home/k/gov/Gov4-Atmp.txt

#Gov4:B
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292NDpC" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov4-Btmp.txt

sort -uf /home/k/gov/Gov4-Btmp.txt > /home/k/gov/Gov4-B.txt
rm /home/k/gov/Gov4-Btmp.txt

#Gov4:C
curl -X GET "https://mainnet-algorand.api.purestake.io/idx2/v2/accounts/FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ/transactions?note-prefix=R292NDpD" -H "x-api-key:API-KEY-HERE" -H 'accept: application/json' | jq -r '.transactions[] | .sender' > /home/k/gov/Gov4-Ctmp.txt

sort -uf /home/k/gov/Gov4-Ctmp.txt > /home/k/gov/Gov4-C.txt
rm /home/k/gov/Gov4-Ctmp.txt

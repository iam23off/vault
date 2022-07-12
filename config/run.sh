rm -rf data
mkdir data

rm -rf logs/log.txt
touch logs/log.txt

./vault server -config=/Users/vpelissi/Projects/RD/Vault/config/vault.hcl

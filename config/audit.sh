export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/config/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault audit enable file file_path=/Users/vpelissi/Projects/RD/Vault/config/logs/log.txt

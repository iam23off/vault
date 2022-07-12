export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/config/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault write pki_int/tidy tidy_cert_store=true tidy_revoked_certs=true
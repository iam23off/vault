export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/config/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault read -field=default pki_int/config/issuers
#(89af13c9-aeb2-0555-4771-1e104c0e66ed)

vault write pki_int/roles/example-dot-com \
     issuer_ref="89af13c9-aeb2-0555-4771-1e104c0e66ed" \
     allowed_domains="example.com" \
     allow_subdomains=true \
     max_ttl="720h"



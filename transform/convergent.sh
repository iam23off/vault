export VAULT_ADDR=http://localhost:8200
export VAULT_FORMT=json
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault write transform/transformations/tokenization/credit-card-convergent \
     allowed_roles="*" \
     convergent=true

vault write transform/role/mobile-pay transformations="credit-card, credit-card-convergent"


vault write transform/encode/mobile-pay value=5555-6666-7777-8888 \
     transformation=credit-card-convergent

vault write transform/encode/mobile-pay value=5555-6666-7777-8888 \
     transformation=credit-card-convergent


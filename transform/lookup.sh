export VAULT_ADDR=http://localhost:8200
export VAULT_FORMT=json
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault write transform/encode/mobile-pay value=5555-6666-7777-8888 \
     transformation=credit-card-convergent ttl=8h

vault write transform/tokens/mobile-pay value=5555-6666-7777-8888 \
    transformation=credit-card-convergent

vault write transform/tokens/mobile-pay value=5555-6666-7777-8888 \
    transformation=credit-card-convergent expiration="any"

vault write transform/tokens/mobile-pay value=5555-6666-7777-8888 \
    transformation=credit-card-convergent \
    min_expiration="2022-09-20T06:30:50+00:00" \
    max_expiration="2022-09-20T14:30:50+00:00"

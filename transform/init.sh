export VAULT_ADDR=http://localhost:8200
export VAULT_FORMT=json
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault secrets enable transform

vault write transform/role/mobile-pay transformations=credit-card

vault write transform/transformations/tokenization/credit-card \
  allowed_roles=mobile-pay \
  max_ttl=24h

vault read transform/transformations/tokenization/credit-card

vault write transform/encode/mobile-pay value=1111-2222-3333-4444 \
     transformation=credit-card \
     ttl=8h \
     metadata="Organization=HashiCorp" \
     metadata="Purpose=Travel" \
     metadata="Type=AMEX"

export MY_TOKEN="9UrVvkyFti5LUPuXBGNqLpGcxA427srBn6X9S8seNtgVaYBYPQndAUwrJ1cJM9rCeoi6Fczv"

vault write transform/metadata/mobile-pay value=$MY_TOKEN transformation=credit-card

vault write transform/validate/mobile-pay value=$MY_TOKEN transformation=credit-card

vault write transform/tokenized/mobile-pay value=1111-2222-3333-4444 transformation=credit-card

vault write transform/decode/mobile-pay transformation=credit-card value=$MY_TOKEN


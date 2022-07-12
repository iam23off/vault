export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

sentinel test

POLICY1=$(base64 cidr-check.sentinel)
vault write sys/policies/egp/cidr-check policy="${POLICY1}" paths="secret/*" enforcement_level="hard-mandatory"

POLICY2=$(base64 business-hrs.sentinel)
vault write sys/policies/egp/business-hrs policy="${POLICY2}" paths="secret/accounting/*" enforcement_level="hard-mandatory"

POLICY3=$(base64 validate-zip-codes.sentinel)
vault write sys/policies/egp/validate-zip-codes policy="${POLICY3}" paths="*" enforcement_level="hard-mandatory"
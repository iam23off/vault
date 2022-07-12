export VAULT_ADDR=http://localhost:8200
export VAULT_FORMT=json
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault write -force auth/approle/role/jenkins/secret-id | jq ".data.secret_id" > secret-id
vault agent -config=/Users/vpelissi/Projects/RD/Vault/CICD/agent/agent.hcl
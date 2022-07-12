export VAULT_ADDR=http://localhost:8200
export VAULT_FORMT=json
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault auth enable approle

vault policy write jenkins -<<EOF
# Read-only permission on secrets stored at 'secret/data/mysql/webapp'
path "secret/data/mysql/webapp" {
  capabilities = [ "read" ]
}
EOF

vault write auth/approle/role/jenkins token_policies="jenkins" token_ttl=1h token_max_ttl=4h

vault read auth/approle/role/jenkins

vault read auth/approle/role/jenkins/role-id

vault write -force auth/approle/role/jenkins/secret-id

vault write auth/approle/login role_id="a04efc6d-8a88-61b4-d2e2-8cf1b98b8ee7" secret_id="64b14290-55c7-ee8d-5704-602ab5b165a3"

export APP_TOKEN="hvs.CAESIHyCOlwdWg88WZvn_dxX5n8A29uIp06iXR0oCTULNi_MGh4KHGh2cy5HRGdmTjQweE1OeDRPVVJVaGM5NDhiQkQ"

VAULT_TOKEN=$APP_TOKEN vault kv get secret/mysql/webapp

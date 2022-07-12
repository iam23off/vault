export VAULT_ADDR=http://localhost:8200
export VAULT_FORMT=json
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN


vault auth enable userpass

vault auth list -detailed

vault write sys/mfa/method/okta/my_okta \
      mount_accessor=auth_userpass_c0514376 \
      org_name=trial-3828893 \
      api_token=00XlaDqbzOxGOMWUAxp_OjaCoH-rFWcAw80jGO2gUT \
      username_format="{{alias.name}}@23.us.org" \
      primary_email=false

vault policy write okta-policy -<<EOF
path "secret/data/foo" {
  capabilities = ["read"]
  mfa_methods  = ["my_okta"]
}
EOF

vault write auth/userpass/users/vpelissi password=testpassword policies=okta-policy

vault write auth/userpass/login/vpelissi password=testpassword

TOKEN=$(vault write auth/userpass/login/vpelissi password=testpassword | jq ".auth.client_token")

vault token lookup $TOKEN

vault login $TOKEN

vault kv get secret/foo
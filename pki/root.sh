export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/config/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault secrets enable pki
vault secrets tune -max-lease-ttl=87600h pki
vault write -field=certificate pki/root/generate/internal common_name="example.com" issuer_name="root-2022" ttl=87600h > root_2022_ca.crt
vault list pki/issuers/
vault write pki/roles/2022-servers allow_any_name=true
vault write pki/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca" crl_distribution_points="$VAULT_ADDR/v1/pki/crl"

export VAULT_ADDR=http://localhost:8200
export VAULT_FORMT=json
export VAULT_TOKEN=$(cat /Users/vpelissi/Projects/RD/Vault/config/root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault login $VAULT_TOKEN

vault secrets enable aws

vault write aws/config/root \
    access_key=AKIAQSO54VPAIEIEDR7P \
    secret_key=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 \
    region=eu-west-1

vault write aws/roles/my-role \
    credential_type=iam_user \
    policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
EOF

vault read aws/creds/my-role

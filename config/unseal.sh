export VAULT_ADDR=http://localhost:8200
export VAULT_FORMAT=json

vault operator init -key-shares=10 -key-threshold=5 > root.json

export KEY_0=$(cat root.json| jq ".unseal_keys_b64[0]")
export KEY_0=$(env | grep KEY_0| tr '"' ' ' | awk '{print $2}')


export KEY_1=$(cat root.json| jq ".unseal_keys_b64[3]")
export KEY_1=$(env | grep KEY_1| tr '"' ' ' | awk '{print $2}')

export KEY_2=$(cat root.json| jq ".unseal_keys_b64[5]")
export KEY_2=$(env | grep KEY_2| tr '"' ' ' | awk '{print $2}')

export KEY_3=$(cat root.json| jq ".unseal_keys_b64[7]")
export KEY_3=$(env | grep KEY_3| tr '"' ' ' | awk '{print $2}')

export KEY_4=$(cat root.json| jq ".unseal_keys_b64[9]")
export KEY_4=$(env | grep KEY_4| tr '"' ' ' | awk '{print $2}')

export VAULT_TOKEN=$(cat root.json| jq ".root_token")
export VAULT_TOKEN=$(env | grep VAULT_TOKEN| tr '"' ' ' | awk '{print $2}')

vault operator unseal $(echo $KEY_0)
vault operator unseal $(echo $KEY_1)
vault operator unseal $(echo $KEY_2)
vault operator unseal $(echo $KEY_3)
vault operator unseal $(echo $KEY_4)

vault login $VAULT_TOKEN
vault status

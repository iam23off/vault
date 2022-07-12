from hvac import Client
from os import environ

client = Client(
    url=environ['VAULT_ADDR'],
    token=environ['VAULT_TOKEN'],
)

status_is_initialized = client.sys.is_initialized()
print(status_is_initialized)


shares = 5
threshold = 3
result = client.sys.initialize(shares, threshold)
root_token = result['root_token']
keys = result['keys']
status_is_initialized = client.sys.is_initialized()
print(status_is_initialized)


client.token = root_token

status_is_sealed = client.sys.is_sealed()
print(status_is_sealed)

# Unseal a Vault cluster with individual keys
unseal_response1 = client.sys.submit_unseal_key(keys[0])
unseal_response2 = client.sys.submit_unseal_key(keys[1])
unseal_response3 = client.sys.submit_unseal_key(keys[2])
status_is_sealed = client.sys.is_sealed()
print(status_is_sealed)

# Seal a previously unsealed Vault cluster.
status_seal = client.sys.seal()
print(status_seal)

status_is_sealed = client.sys.is_sealed()
print(status_is_sealed)

# Unseal with multiple keys until threshold met
unseal_response = client.sys.submit_unseal_keys(keys)

status_is_sealed = client.sys.is_sealed()
print(status_is_sealed)

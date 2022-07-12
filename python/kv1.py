from hvac import Client
from os import environ

client = Client(
    url=environ['VAULT_ADDR'],
    token=environ['VAULT_TOKEN'],
)

print(client.is_authenticated())

create_response = client.secrets.kv.v1.create_or_update_secret('foo', secret=dict(baz='bar'))
print(create_response)

read_response = client.secrets.kv.v1.read_secret('foo')
print('Value under path "secret/foo" / key "baz": {val}'.format(val=read_response['data']['baz'],))

delete_response = client.secrets.kv.v1.delete_secret('foo')

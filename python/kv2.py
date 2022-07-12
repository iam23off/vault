from hvac import Client
from os import environ

client = Client(
    url=environ['VAULT_ADDR'],
    token=environ['VAULT_TOKEN'],
)
print(client.is_authenticated())

create_response = client.secrets.kv.v2.create_or_update_secret(path='foo', secret=dict(baz='toto'))
print(create_response)

read_response = client.secrets.kv.read_secret_version(path='foo')
print('Value under path "secret/foo" / key "baz": {val}'.format(val=read_response['data']['data']['baz'],))

delete_response = client.secrets.kv.delete_metadata_and_all_versions('foo')
print(delete_response)

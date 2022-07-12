# To request data encoding using any of the roles
# Specify the role name in the path to narrow down the scope
path "transform/encode/mobile-pay" {
   capabilities = [ "update" ]
}

# To request data decoding using any of the roles
# Specify the role name in the path to narrow down the scope
path "transform/decode/mobile-pay" {
   capabilities = [ "update" ]
}

# To validate the token
path "transform/validate/mobile-pay" {
   capabilities = [ "update" ]
}

# To retrieve the metadata belong to the token
path "transform/metadata/mobile-pay" {
   capabilities = [ "update" ]
}

# To check and see if the secret is tokenized
path "transform/tokenized/mobile-pay" {
   capabilities = [ "update" ]
}

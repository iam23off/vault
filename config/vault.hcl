ui = true

storage "file" {
  path = "/Users/vpelissi/Projects/RD/Vault/Config/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

license_path="/Users/vpelissi/Projects/RD/Vault/config/licences/license.hclic"

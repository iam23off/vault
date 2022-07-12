pid_file = "./pidfile"
exit_after_auth = true

auto_auth {
  method "approle" {
    config = {
      role_id_file_path = "/Users/vpelissi/Projects/RD/Vault/CICD/agent/role-id"
      secret_id_file_path = "/Users/vpelissi/Projects/RD/Vault/CICD/agent/secret-id"
    }
  }

  sink "file" {
    config = {
      path = "/tmp/vault-token"
    }
  }
}

cache {
  use_auto_auth_token = true
}

template {
  contents = <<EOF
    {{ with secret "secret/mysql/webapp" }}
export DB_KV={{.Data.data.DB_KV}}
export DB_HOST={{.Data.data.DB_HOST}}
export DB_PASSWORD={{.Data.data.DB_PASSWORD}}
export DB_USERNAME={{.Data.data.DB_USERNAME}}
    {{ end }}
  EOF
  destination = "/Users/vpelissi/Projects/RD/Vault/CICD/agent/vault/secret/mysql/webapp"
}
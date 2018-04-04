storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
}

// TODO enable TLS for vault
listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = true
}

listener "tcp" {
  address     = "$PRIVATE_IP:8200"
  tls_disable = true
}

api_addr = "http://$PRIVATE_IP:8200"

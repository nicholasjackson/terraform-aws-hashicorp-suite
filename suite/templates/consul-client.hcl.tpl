datacenter = "${datacenter}"
bind_addr = "0.0.0.0"

advertise_addr = "$PRIVATE_IP"
advertise_addr_wan = "$PRIVATE_IP"
addresses {
  http = "0.0.0.0"
}

data_dir = "/mnt/consul"

disable_remote_exec = true
disable_update_check = true
leave_on_terminate = true

retry_join = [
  "provider=aws tag_key=${consul_join_tag_key} tag_value=${consul_join_tag_value}"
  ]
  
server = false

connect {
  enabled = true
  proxy {
    allow_managed_api_registration = true
    allow_managed_root = true
  }
}

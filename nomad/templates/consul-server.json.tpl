{
  "datacenter": "${datacenter}",
  "bind_addr": "0.0.0.0",
  "advertise_addr": "$PRIVATE_IP",
  "advertise_addr_wan": "$PRIVATE_IP",
  "addresses": {
    "http": "0.0.0.0"
  },
  "data_dir": "/mnt/consul",
  "disable_remote_exec": true,
  "disable_update_check": true,
  "bootstrap_expect": ${instances},
  "leave_on_terminate": true,
  "retry_join": ["provider=aws tag_key=${consul_join_tag_key} tag_value=${consul_join_tag_value}"],
  "server": true,
  "raft_protocol": 3,
  "autopilot": {
    "cleanup_dead_servers": true,
    "last_contact_threshold": "200ms",
    "max_trailing_logs": 250,
    "server_stabilization_time": "10s"
  }
}

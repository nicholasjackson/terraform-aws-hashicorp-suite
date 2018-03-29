# AWS HashiCorp Suite Terraform module
This module allows you to create simple Nomad and Consul clusters

## Example Nomad Cluster with Consul
```hcl
module "nomad" {
  source = "/Users/nicj/Developer/hashicorp/terraform-aws-hashicorp-suite"

  namespace = "${var.namespace}"

  min_servers = "1"
  max_servers = "1"
  min_agents  = "3"
  max_agents  = "3"

  subnets        = ["${aws_subnet.default.*.id}"]
  vpc_id         = "${aws_vpc.default.id}"
  key_name       = "${aws_key_pair.nomad.id}"
  security_group = "${aws_security_group.allow_all.id}"

  client_target_groups = ["${aws_alb_target_group.proxy.arn}", "${aws_alb_target_group.faas.arn}"]
  server_target_groups = ["${aws_alb_target_group.nomad.arn}"]

  consul_enabled        = true
  consul_version        = "1.0.6"
  consul_join_tag_key   = "AutoJoin"
  consul_join_tag_value = "${var.namespace}"

  nomad_enabled = true
  nomad_version = "0.7.1"
}
```

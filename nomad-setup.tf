module "servers" {
  source = "./nomad"

  namespace     = "${var.namespace}-server"
  min_instances = "${var.min_servers}"
  max_instances = "${var.max_servers}"
  instance_type = "${var.instance_type}"

  subnets        = ["${var.subnets}"]
  vpc_id         = "${var.vpc_id}"
  security_group = "${var.security_group}"
  key_name       = "${var.key_name}"

  target_groups = ["${var.server_target_groups}"]

  consul_enabled        = true
  consul_type           = "server"
  consul_version        = "${var.consul_version}"
  consul_join_tag_key   = "${var.consul_join_tag_key}"
  consul_join_tag_value = "${var.consul_join_tag_value}"

  nomad_datacentre = "${var.nomad_datacentre}"
  nomad_region     = "${var.nomad_region}"
  nomad_enabled    = true
  nomad_type       = "server"
  nomad_version    = "${var.nomad_version}"
}

module "clients" {
  source = "./nomad"

  namespace     = "${var.namespace}-client"
  min_instances = "${var.min_agents}"
  max_instances = "${var.max_agents}"
  instance_type = "${var.instance_type}"

  subnets        = ["${var.subnets}"]
  vpc_id         = "${var.vpc_id}"
  security_group = "${var.security_group}"
  key_name       = "${var.key_name}"

  target_groups = ["${var.client_target_groups}"]

  consul_enabled        = true
  consul_type           = "client"
  consul_version        = "${var.consul_version}"
  consul_join_tag_key   = "${var.consul_join_tag_key}"
  consul_join_tag_value = "${var.consul_join_tag_value}"

  nomad_datacentre = "${var.nomad_datacentre}"
  nomad_region     = "${var.nomad_region}"
  nomad_enabled    = true
  nomad_type       = "client"
  nomad_version    = "${var.nomad_version}"
}

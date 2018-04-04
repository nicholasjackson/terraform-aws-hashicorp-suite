variable "namespace" {}

variable "min_instances" {
  description = "Minimum number of servers."
}

variable "max_instances" {
  description = "Maximum number of nomad servers."
}

# ALB Settings
variable "target_groups" {
  description = "List of target groups to attach to autoscaling group"
  type        = "list"
  default     = []
}

# AWS Specific variables
variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "The id of the ssh key to add to the servers"
}

variable "subnets" {
  description = "A list of subnets to attach the instances to"
  type        = "list"
}

variable "vpc_id" {
  description = "The id of the VPC which the servers are attached to"
}

variable "security_group" {
  description = "The id of the security group"
}

# Consul configuration
variable "consul_enabled" {
  description = "Should consul be installed onto the instance?"
}

variable "consul_type" {
  description = "Is the consul instance a server or client"
}

variable "consul_version" {
  description = "Version number for nomad"
}

variable "consul_join_tag_key" {
  description = "AWS Tag to use for consul auto-join"
}

variable "consul_join_tag_value" {
  description = "Value to search for in auto-join tag to use for consul auto-join"
}

# Nomad configuration
variable "nomad_datacentre" {
  description = "Default datacenter for Nomad"
  default     = "dc1"
}

variable "nomad_region" {
  description = "Default datacenter for Nomad"
  default     = "aws"
}

variable "nomad_enabled" {
  description = "Is nomad enabled on this instance"
}

variable "nomad_type" {
  description = "Is nomad a server or an agent"
}

variable "nomad_version" {
  description = "Version number for nomad"
}

variable "nomad_consul_uri" {
  description = "Location of consul server for bootstrapping"
  default     = "http://localhost:8500"
}

# Vault settings
variable "vault_enabled" {
  description = "Is vault enabled on this instance"
}

variable "vault_version" {
  description = "Vault version to install"
}

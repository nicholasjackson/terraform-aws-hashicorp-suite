# Generic
variable "instance_type" {
  default = "t2.micro"
}

variable "namespace" {
  description = "Namespace for application, all resources will be prefixed with namespace"
}

variable "min_servers" {
  description = "The minimum number of servers to add to the autoscale group"
}

variable "max_servers" {
  description = "The maximum number of servers allowed in the autoscale group"
}

variable "min_agents" {
  description = "The minimum number of agents to add to the autoscale group"
}

variable "max_agents" {
  description = "The maximum number of agents allowed in the autoscale group"
}

# Networking
variable "subnets" {
  description = "Subnets to launch instances in"
  type        = "list"
}

variable "vpc_id" {
  description = "ID of the vpc to attach instances to"
}

variable "key_name" {
  description = "SSH key to add to instances"
}

variable "security_group" {
  description = "ID of security group to attach to instances"
}

# ALB Settings
variable "server_target_groups" {
  description = "List of target groups to attach to autoscaling group"
  type        = "list"
  default     = []
}

variable "client_target_groups" {
  description = "List of target groups to attach to autoscaling group"
  type        = "list"
  default     = []
}

# Consul settings
variable "consul_version" {
  description = "Consul version to install"
}

variable "consul_join_tag_key" {
  description = "AWS Tag to use for consul auto-join"
}

variable "consul_join_tag_value" {
  description = "Value to search for in auto-join tag to use for consul auto-join"
}

variable "consul_enabled" {
  description = "Is consul enabled on this instance"
}

# Nomad settings
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

variable "nomad_version" {
  description = "Nomad version to install"
}

# HashiUI configuration
variable "hashiui_enabled" {
  description = "Is HashiUI enabled on this instance"
}

variable "hashiui_version" {
  description = "Version number for hashi-ui"
}

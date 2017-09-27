output "alb_dns" {
  value = "${aws_alb.external.dns_name}"
}

output "alb_arn" {
  value = "${aws_alb.external.arn}"
}

output "alb_internal_dns" {
  value = "${aws_elb.consul.dns_name}"
}

output "alb_internal_zone_id" {
  value = "${aws_elb.consul.zone_id}"
}

output "ssh_host" {
  value = "${module.ssh.ssh_host}"
}

output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "vpc_subnet" {
  value = ["${aws_subnet.default.*.id}"]
}

output "cidr" {
  value = "${aws_vpc.default.cidr_block}"
}

output "security_group" {
  value = "${aws_security_group.default.id}"
}

output "route_table_id" {
  value = "${aws_vpc.default.main_route_table_id}"
}

output "vpn_gateway" {
  value = "${aws_internet_gateway.default.id}"
}

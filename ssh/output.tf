output "ssh_host" {
  value = "${aws_instance.ssh_host.public_ip}"
}

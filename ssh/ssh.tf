# Get the list of official Canonical Ubuntu 16.04 AMIs
data "aws_ami" "ubuntu-1604" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "startup" {
  template = "${file("${path.module}/templates/startup.sh.tpl")}"

  vars {
    nomad_version = "${var.nomad_version}"
    nomad_alb     = "${var.nomad_dns}"
  }
}

# A security group that makes the instances accessible
resource "aws_security_group" "ssh" {
  name_prefix = "${var.namespace}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ssh_host" {
  ami           = "${data.aws_ami.ubuntu-1604.id}"
  instance_type = "t2.nano"
  key_name      = "${var.key_name}"

  subnet_id              = "${element(var.subnets,0)}"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
  user_data              = "${data.template_file.startup.rendered}"

  tags = "${map(
    "Name", "${var.namespace}-ssh-host",
  )}"
}

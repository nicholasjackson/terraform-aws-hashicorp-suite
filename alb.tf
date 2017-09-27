# Create a new load balancer
resource "aws_alb" "external" {
  name            = "${var.namespace}-external"
  internal        = false
  security_groups = ["${aws_security_group.default.id}"]
  subnets         = ["${aws_subnet.default.*.id}"]
}

resource "aws_alb" "internal" {
  name            = "${var.namespace}-internal"
  internal        = true
  security_groups = ["${aws_security_group.default.id}"]
  subnets         = ["${aws_subnet.default.*.id}"]
}

resource "aws_elb" "consul" {
  name            = "${var.namespace}-internal"
  subnets         = ["${aws_subnet.default.*.id}"]
  internal        = "true"
  security_groups = ["${aws_security_group.default.id}"]

  listener {
    instance_port     = 8302
    instance_protocol = "tcp"
    lb_port           = 8302
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8302"
    interval            = 30
  }
}

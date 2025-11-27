resource "aws_elb" "clb" {
  name            = "tomcat-clb"
  subnets         = var.subnets
  security_groups = var.security_groups
  instances       = var.instances

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/login"
    interval            = 30
  }

  tags = {
    Name = "tomcat-clb"
  }
}

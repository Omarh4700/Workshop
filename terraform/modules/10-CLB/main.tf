resource "aws_elb" "grafana_clb" {
  name            = var.grafana_clb_name
  subnets         = var.subnets
  security_groups = var.security_groups

  listener {
    instance_port     = 30666
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:30666/login"
    interval            = 30
  }

  instances                   = var.instances
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = var.grafana_clb_name
  }
}
#========================================
# create CLB for Tomcat
#========================================
resource "aws_elb" "tomcat_clb" {
  name            = var.tomcat_clb_name
  subnets         = var.subnets
  security_groups = var.security_groups
  instances       = var.instances

  listener {
    instance_port     = 32080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:32080/login"
    interval            = 30
  }

  tags = {
    Name = var.tomcat_clb_name
  }
}

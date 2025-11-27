# ============================================================================
# SECURITY GROUP RESOURCES (without cross-references)
# ============================================================================

# CLB Security Group
resource "aws_security_group" "clb-sg" {
  name        = "clb-sg"
  description = "Security group for Classic Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "clb-sg"
  }
}

# Ephemeral Worker Security Group
resource "aws_security_group" "ephemeral_worker-sg" {
  name        = "ephemeral_worker-sg"
  description = "Security group for ephemeral_worker host"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ephemeral_worker-sg"
  }
}

# Tomcat Security Group
resource "aws_security_group" "tomcat-sg" {
  name        = "tomcat-sg"
  description = "Security group for Tomcat servers"
  vpc_id      = var.vpc_id

  tags = {
    Name = "tomcat-sg"
  }
}

# Backend Security Group for RDS, ElastiCache, Amazon MQ
resource "aws_security_group" "backend_vp_app_sg" {
  name        = "backend_vp_app_sg"
  description = "Security group for Backend App (RDS, ElastiCache, Amazon MQ)"
  vpc_id      = var.vpc_id

  tags = {
    Name = "backend_vp_app_sg"
  }
}

# ============================================================================
# CLB SECURITY GROUP RULES
# ============================================================================

# CLB Ingress Rules
resource "aws_security_group_rule" "clb_ingress_http" {
  type              = "ingress"
  description       = "Allow inbound HTTP traffic from anywhere"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.clb-sg.id
}

# CLB Egress Rules
resource "aws_security_group_rule" "clb_egress_http_to_tomcat" {
  type                     = "egress"
  description              = "Allow outbound HTTP traffic to Tomcat servers"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tomcat-sg.id
  security_group_id        = aws_security_group.clb-sg.id
}

resource "aws_security_group_rule" "clb_egress_8080_to_tomcat" {
  type                     = "egress"
  description              = "Allow outbound traffic to Tomcat servers on port 8080"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tomcat-sg.id
  security_group_id        = aws_security_group.clb-sg.id
}

# ============================================================================
# EPHEMERAL WORKER SECURITY GROUP RULES
# ============================================================================

# Ephemeral Worker Ingress Rules
resource "aws_security_group_rule" "ephemeral_worker_ingress_ssh" {
  type              = "ingress"
  description       = "Allow inbound SSH traffic from admin CIDR blocks"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.admin_cidr_blocks
  security_group_id = aws_security_group.ephemeral_worker-sg.id
}

resource "aws_security_group_rule" "ephemeral_worker_ingress_http" {
  type              = "ingress"
  description       = "Allow http traffic for update the system"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ephemeral_worker-sg.id
}

# Ephemeral Worker Egress Rules
resource "aws_security_group_rule" "ephemeral_worker_egress_http" {
  type              = "egress"
  description       = "Allow outbound HTTP traffic to update the system"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ephemeral_worker-sg.id
}

# Ephemeral Worker Egress Rules
resource "aws_security_group_rule" "ephemeral_worker_egress_https" {
  type              = "egress"
  description       = "Allow outbound HTTPS traffic to clone the Repo "
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ephemeral_worker-sg.id
}

resource "aws_security_group_rule" "ephemeral_worker_egress_ssh_to_tomcat" {
  type                     = "egress"
  description              = "Allow outbound SSH to Tomcat servers"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tomcat-sg.id
  security_group_id        = aws_security_group.ephemeral_worker-sg.id
}

resource "aws_security_group_rule" "ephemeral_worker_egress_mysql_to_backend" {
  type                     = "egress"
  description              = "Allow outbound MySQL traffic to backend services"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend_vp_app_sg.id
  security_group_id        = aws_security_group.ephemeral_worker-sg.id
}

# ============================================================================
# TOMCAT SECURITY GROUP RULES
# ============================================================================

# Tomcat Ingress Rules
resource "aws_security_group_rule" "tomcat_ingress_8080_from_clb" {
  type                     = "ingress"
  description              = "Allow inbound traffic from CLB on port 8080"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.clb-sg.id
  security_group_id        = aws_security_group.tomcat-sg.id
}

resource "aws_security_group_rule" "tomcat_ingress_http_from_clb" {
  type                     = "ingress"
  description              = "Allow inbound HTTP traffic from CLB"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.clb-sg.id
  security_group_id        = aws_security_group.tomcat-sg.id
}

resource "aws_security_group_rule" "tomcat_ingress_http_from_anywhere" {
  type              = "ingress"
  description       = "Allow  http from anywhere to update the system"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tomcat-sg.id
}

resource "aws_security_group_rule" "tomcat_ingress_ssh_from_ephemeral" {
  type                     = "ingress"
  description              = "Allow inbound SSH traffic from ephemeral_worker only"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ephemeral_worker-sg.id
  security_group_id        = aws_security_group.tomcat-sg.id
}

# Tomcat Egress Rules
resource "aws_security_group_rule" "tomcat_egress_http" {
  type              = "egress"
  description       = "Allow outbound HTTP traffic"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tomcat-sg.id
}

resource "aws_security_group_rule" "tomcat_egress_mysql_to_backend" {
  type                     = "egress"
  description              = "Allow outbound MySQL traffic to backend services"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend_vp_app_sg.id
  security_group_id        = aws_security_group.tomcat-sg.id
}

resource "aws_security_group_rule" "tomcat_egress_memcache_to_backend" {
  type                     = "egress"
  description              = "Allow outbound memcache traffic to backend services"
  from_port                = 11211
  to_port                  = 11211
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend_vp_app_sg.id
  security_group_id        = aws_security_group.tomcat-sg.id
}

resource "aws_security_group_rule" "tomcat_egress_rabbitmq_to_backend" {
  type                     = "egress"
  description              = "Allow outbound RabbitMQ traffic to backend services"
  from_port                = 5671
  to_port                  = 5671
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend_vp_app_sg.id
  security_group_id        = aws_security_group.tomcat-sg.id
}

# ============================================================================
# BACKEND SECURITY GROUP RULES
# ============================================================================

# Backend Ingress Rules - MySQL/RDS (Port 3306)
resource "aws_security_group_rule" "backend_ingress_mysql_from_tomcat" {
  type                     = "ingress"
  description              = "Allow MySQL connections from Tomcat servers"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tomcat-sg.id
  security_group_id        = aws_security_group.backend_vp_app_sg.id
}

resource "aws_security_group_rule" "backend_ingress_mysql_from_ephemeral" {
  type                     = "ingress"
  description              = "Allow MySQL connections from Ephemeral Worker"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ephemeral_worker-sg.id
  security_group_id        = aws_security_group.backend_vp_app_sg.id
}

# Backend Ingress Rules - ElastiCache memcache (Port 11211)
resource "aws_security_group_rule" "backend_ingress_memcache_from_tomcat" {
  type                     = "ingress"
  description              = "Allow memcache connections from Tomcat servers"
  from_port                = 11211
  to_port                  = 11211
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tomcat-sg.id
  security_group_id        = aws_security_group.backend_vp_app_sg.id
}

# Backend Ingress Rules - Amazon MQ RabbitMQ (Port 5671)
resource "aws_security_group_rule" "backend_ingress_rabbitmq_from_tomcat" {
  type                     = "ingress"
  description              = "Allow RabbitMQ connections from Tomcat servers"
  from_port                = 5671
  to_port                  = 5671
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tomcat-sg.id
  security_group_id        = aws_security_group.backend_vp_app_sg.id
}

# Backend Egress Rules
resource "aws_security_group_rule" "backend_egress_to_tomcat" {
  type                     = "egress"
  description              = "Allow outbound traffic to Tomcat servers"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tomcat-sg.id
  security_group_id        = aws_security_group.backend_vp_app_sg.id
}

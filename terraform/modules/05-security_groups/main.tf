#========================================
# create security group for bastion host
#========================================
resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group_rule" "bastion_ingress_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all inbound traffic"
  security_group_id = aws_security_group.bastion-sg.id
}

#========================================
# create security group for master node
#========================================
resource "aws_security_group" "master" {
  name        = "master-sg"
  description = "Security group for master nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "master-sg"
  }
}

resource "aws_security_group_rule" "master_ssh_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-sg.id
  description              = "SSH access from bastion host"
  security_group_id        = aws_security_group.master.id
}

resource "aws_security_group_rule" "master_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  description       = "Allow all inbound traffic from master security group"
  security_group_id = aws_security_group.master.id
}

resource "aws_security_group_rule" "master_api_from_workers" {
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.workers.id
  description              = "Kubernetes API server from workers"
  security_group_id        = aws_security_group.master.id
}

resource "aws_security_group_rule" "master_etcd_from_workers" {
  type                     = "ingress"
  from_port                = 2379
  to_port                  = 2380
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.workers.id
  description              = "etcd server client API"
  security_group_id        = aws_security_group.master.id
}

resource "aws_security_group_rule" "master_kubelet_from_workers" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.workers.id
  description              = "Kubelet API"
  security_group_id        = aws_security_group.master.id
}

resource "aws_security_group_rule" "master_scheduler_from_workers" {
  type                     = "ingress"
  from_port                = 10259
  to_port                  = 10259
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.workers.id
  description              = "kube-scheduler"
  security_group_id        = aws_security_group.master.id
}

resource "aws_security_group_rule" "master_controller_from_workers" {
  type                     = "ingress"
  from_port                = 10257
  to_port                  = 10257
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.workers.id
  description              = "kube-controller-manager"
  security_group_id        = aws_security_group.master.id
}

resource "aws_security_group_rule" "grafana_nodeport_tcp_from_master" {
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.master.id
  description              = "NodePort Services TCP from master"
  security_group_id        = aws_security_group.master.id
}

resource "aws_security_group_rule" "grafana_nodeport_tcp_from_clb" {
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.clb.id
  description              = "NodePort Services TCP from CLB"
  security_group_id        = aws_security_group.master.id
}

resource "aws_security_group_rule" "master_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Open ICMP protocole from every where"
  security_group_id = aws_security_group.master.id
}

resource "aws_security_group_rule" "master_allow_all_from_workers" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.workers.id
  description              = "Allow all inbound traffic from workers"
  security_group_id        = aws_security_group.master.id
}

#========================================
# create security group for worker nodes
#========================================
resource "aws_security_group" "workers" {
  name        = "worker-sg"
  description = "Security group for worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "worker-sg"
  }
}

resource "aws_security_group_rule" "workers_ssh_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-sg.id
  description              = "SSH access from bastion host"
  security_group_id        = aws_security_group.workers.id
}

resource "aws_security_group_rule" "workers_kubelet_from_master" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.master.id
  description              = "Kubelet API from master"
  security_group_id        = aws_security_group.workers.id
}

resource "aws_security_group_rule" "workers_kubeproxy_from_master" {
  type                     = "ingress"
  from_port                = 10256
  to_port                  = 10256
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.master.id
  description              = "kube-proxy from master"
  security_group_id        = aws_security_group.workers.id
}

resource "aws_security_group_rule" "workers_nodeport_tcp_from_master" {
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.master.id
  description              = "NodePort Services TCP from master"
  security_group_id        = aws_security_group.workers.id
}

resource "aws_security_group_rule" "workers_nodeport_udp_from_master" {
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "udp"
  source_security_group_id = aws_security_group.master.id
  description              = "NodePort Services UDP from master"
  security_group_id        = aws_security_group.workers.id
}

resource "aws_security_group_rule" "workers_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  description       = "Allow all inbound traffic from workers security group"
  security_group_id = aws_security_group.workers.id
}

resource "aws_security_group_rule" "workers_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Open ICMP protocole from every where"
  security_group_id = aws_security_group.workers.id
}

resource "aws_security_group_rule" "workers_allow_all_from_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.master.id
  description              = "Allow all inbound traffic from master"
  security_group_id        = aws_security_group.workers.id
}

resource "aws_security_group_rule" "workers_nodeport_tcp_from_clb" {
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.clb.id
  description              = "NodePort Services TCP from CLB"
  security_group_id        = aws_security_group.workers.id
}


#========================================
# create security group for Jenkins
#========================================
resource "aws_security_group" "jenkins" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins server"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_security_group_rule" "jenkins_ssh_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-sg.id
  description              = "SSH access from bastion host"
  security_group_id        = aws_security_group.jenkins.id
}

resource "aws_security_group_rule" "jenkins_web_ui" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Jenkins web UI access"
  security_group_id = aws_security_group.jenkins.id
}

resource "aws_security_group_rule" "jenkins_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "ICMP from anywhere"
  security_group_id = aws_security_group.jenkins.id
}

#========================================
# create security group for CLB
#========================================
resource "aws_security_group" "clb" {
  name        = "clb-sg"
  description = "Security group for CLB"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "clb-sg"
  }
}

resource "aws_security_group_rule" "CLB_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow HTTP inbound traffic"
  security_group_id = aws_security_group.clb.id
}

resource "aws_security_group_rule" "CLB_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow HTTPS inbound traffic"
  security_group_id = aws_security_group.clb.id
}

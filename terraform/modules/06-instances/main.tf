#========================================
# create key pair for bastion host
#========================================
resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.bastion_key.private_key_pem}' > ./bastion-key.pem && chmod 600 ./bastion-key.pem"
  }
}
#========================================
# create instances (master, worker, bastion)
#========================================
resource "aws_instance" "master" {
  ami                  = var.ami
  instance_type        = var.master_instance_type
  key_name             = aws_key_pair.bastion_key.key_name
  subnet_id            = var.private_subnet_id
  security_groups      = [var.master_sg_id]
  iam_instance_profile = var.k8s_nodes_instance_profile_name

  root_block_device {
    volume_size = var.master_root_volume_size
    # add name of the volume
    volume_type = "gp3"

    tags = {
      Name = "master-volume"
    }
  }
  tags = {
    Name = "master"
  }
}
resource "aws_instance" "worker" {
  count                = 2
  ami                  = var.ami
  instance_type        = var.worker_instance_type
  key_name             = aws_key_pair.bastion_key.key_name
  subnet_id            = var.private_subnet_id
  security_groups      = [var.worker_sg_id]
  iam_instance_profile = var.k8s_nodes_instance_profile_name

  root_block_device {
    volume_size = var.worker_root_volume_size
    # add name of the volume
    volume_type = "gp3"

    tags = {
      Name = "worker-${count.index + 1}-volume"
    }
  }
  depends_on = [aws_instance.master]

  tags = {
    Name = "worker-${count.index + 1}"
  }
}
resource "aws_instance" "bastion" {
  ami             = var.ami
  instance_type   = var.bastion_instance_type
  key_name        = aws_key_pair.bastion_key.key_name
  subnet_id       = var.public_subnet_id
  security_groups = [var.bastion_sg_id]

  tags = {
    Name = "bastion"
  }
}

#========================================
# create EBS volume for Jenkins data
#========================================
resource "aws_ebs_volume" "jenkins_data" {
  availability_zone = aws_instance.bastion.availability_zone
  size              = var.jenkins_ebs_size
  type              = "gp3"

  # lifecycle {
  #   prevent_destroy = true
  # }

  tags = {
    Name = "jenkins-data"
  }
}

#========================================
# attach EBS volume to Jenkins instance
#========================================
resource "aws_volume_attachment" "jenkins_data_attachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.jenkins_data.id
  instance_id = aws_instance.jenkins.id
}

#========================================
# create Jenkins instance
#========================================
resource "aws_instance" "jenkins" {
  ami                  = var.ami
  instance_type        = var.jenkins_instance_type
  key_name             = aws_key_pair.bastion_key.key_name
  subnet_id            = var.public_subnet_id
  security_groups      = [var.jenkins_sg_id]
  iam_instance_profile = var.jenkins_instance_profile_name

  user_data = file("${path.module}/scripts/jenkins_install.sh")

  # lifecycle {
  #   prevent_destroy = true
  # }

  tags = {
    Name = "jenkins"
  }
}

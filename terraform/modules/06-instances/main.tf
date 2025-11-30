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
  ami             = var.ami
  instance_type   = var.master_instance_type
  key_name        = aws_key_pair.bastion_key.key_name
  subnet_id       = var.private_subnet_id
  security_groups = [var.master_sg_id]
  tags = {
    Name = "master"
  }
}
resource "aws_instance" "worker" {
  count           = 2
  ami             = var.ami
  instance_type   = var.worker_instance_type
  key_name        = aws_key_pair.bastion_key.key_name
  subnet_id       = var.private_subnet_id
  security_groups = [var.worker_sg_id]
  depends_on      = [aws_instance.master]

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

resource "tls_private_key" "vp-app_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "vp-app_key_pair" {
  key_name   = "vp-app-key-pair"
  public_key = tls_private_key.vp-app_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.vp-app_key.private_key_pem}' > ./vp-app_key.pem && chmod 600 ./vp-app_key.pem"
  }
}

# Create EC2 Instance for ephemeral_worker_instance 
resource "aws_instance" "ephemeral_worker_instance" {
  ami                    = var.ami_id
  instance_type          = var.ephemeral_worker_instance_type
  subnet_id              = var.ephemeral_worker_subnet_id
  vpc_security_group_ids = [var.ephemeral_worker_sg_id]
  key_name               = aws_key_pair.vp-app_key_pair.key_name
  user_data = templatefile("${path.module}/worker_userdata.tftpl", {
    rds_address = var.rds_address
    db_username = var.db_username
    db_password = var.db_password
    db_name     = var.db_name
  })
  instance_initiated_shutdown_behavior = "terminate"
  associate_public_ip_address          = true
  tags = {
    Name = "Ephemeral-Worker-Instance"
    Type = "Ephemeral-Worker"
  }
}
# End of EC2 Instance for ephemeral worker
# tomcat EC2 Instance
resource "aws_instance" "tomcat_instance" {
  ami                    = var.ami_id
  instance_type          = var.tomcat_instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.tomcat_sg_id]
  key_name               = aws_key_pair.vp-app_key_pair.key_name
  user_data = templatefile("${path.module}/userdata.sh", {
    RDS_Endpoint             = var.rds_endpoint
    db_username              = var.db_username
    db_password              = var.db_password
    ElastiCache_Endpoint     = var.elasticache_endpoint
    RabbitMQ_broker_endpoint = var.rabbitmq_endpoint
    Amazon-MQ-username       = var.rabbitmq_username
    Amazon-MQ-password       = var.rabbitmq_password
  })
  user_data_replace_on_change = true
  associate_public_ip_address = true
  tags = {
    Name = "Tomcat-Instance"
    Type = "Tomcat-Server"
  }
}
# End of tomcat EC2 Instance

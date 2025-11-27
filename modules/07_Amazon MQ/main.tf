resource "aws_mq_broker" "RabbitMQ_broker" {
  broker_name                = var.Amazon-MQ-broker_name
  engine_type                = var.Amazon-MQ-engine_type
  engine_version             = var.Amazon-MQ-engine_version
  host_instance_type         = var.Amazon-MQ-host_instance_type
  security_groups            = [var.Amazon-MQ-sg_id]
  subnet_ids                 = var.Amazon-MQ-subnet_ids # Added subnet_ids
  publicly_accessible        = false
  auto_minor_version_upgrade = true
  user {
    username = var.Amazon-MQ-username
    password = var.Amazon-MQ-password
  }
  tags = {
    Name = var.Amazon-MQ-broker_name
    Type = "Amazon-MQ-Broker"
  }
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0ecb62995f68bb549" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
}
variable "tomcat_instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
  default     = "t3.large"
}
variable "ephemeral_worker_instance_type" {
  description = "The instance type for the ephemeral worker"
  type        = string
  default     = "t3.micro"
}
variable "public_subnet_id" {
  description = "The ID of the public subnet to launch tomcat instance in"
  type        = string
}
variable "ephemeral_worker_subnet_id" {
  description = "The ID of the public subnet to launch ephemeral worker instance in (subnet B)"
  type        = string
}
variable "ephemeral_worker_sg_id" {
  description = "The ID of the security group for the ephemeral worker"
  type        = string
}
variable "tomcat_sg_id" {
  description = "The ID of the security group for the Tomcat server"
  type        = string
}

variable "rds_address" {
  description = "The address of the RDS instance"
  type        = string
}
variable "db_username" {
  description = "The master username for the database"
  type        = string
}
variable "db_password" {
  description = "The master password for the database"
  type        = string
}
variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "rds_endpoint" {
  description = "The endpoint of the RDS instance (with port)"
  type        = string
}
variable "elasticache_endpoint" {
  description = "The endpoint of the ElastiCache cluster"
  type        = string
}
variable "rabbitmq_endpoint" {
  description = "The endpoint of the RabbitMQ broker"
  type        = string
}
variable "rabbitmq_username" {
  description = "The username for the RabbitMQ broker"
  type        = string
}
variable "rabbitmq_password" {
  description = "The password for the RabbitMQ broker"
  type        = string
}

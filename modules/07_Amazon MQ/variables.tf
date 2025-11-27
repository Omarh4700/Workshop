variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "Amazon-MQ-engine_type" {
  description = "The engine type for Amazon MQ broker"
  default     = "RabbitMQ"
  type        = string
}
variable "Amazon-MQ-engine_version" {
  description = "The engine version for Amazon MQ broker"
  default     = "4.2"
  type        = string
}
variable "Amazon-MQ-host_instance_type" {
  description = "The host instance type for Amazon MQ broker"
  default     = "mq.m7g.medium"
  type        = string
}
variable "Amazon-MQ-broker_name" {
  description = "The name of the Amazon MQ broker"
  default     = "vp-app-rabbitmq-broker"
  type        = string
}
variable "Amazon-MQ-username" {
  description = "The username for the Amazon MQ broker"
  default     = "admin"
  type        = string
}
variable "Amazon-MQ-password" {
  description = "The password for the Amazon MQ broker"
  default     = "admin1234567"
  type        = string
  sensitive   = true
}
variable "Amazon-MQ-sg_id" {
  description = "The ID of the Amazon MQ security group"
  type        = string
}
variable "Amazon-MQ-subnet_ids" {
  description = "The IDs of the subnets for the Amazon MQ broker"
  type        = list(string)
}

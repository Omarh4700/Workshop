output "RabbitMQ_broker_id" {
  description = "The ID of the Amazon MQ RabbitMQ broker"
  value       = aws_mq_broker.RabbitMQ_broker.id
}
output "RabbitMQ_broker_arn" {
  description = "The ARN of the Amazon MQ RabbitMQ broker"
  value       = aws_mq_broker.RabbitMQ_broker.arn
}
output "RabbitMQ_broker_endpoint" {
  description = "The endpoint of the Amazon MQ RabbitMQ broker (hostname only)"
  value       = replace(replace(aws_mq_broker.RabbitMQ_broker.instances[0].endpoints[0], "amqps://", ""), ":5671", "")
}
output "Amazon-MQ-username" {
  description = "The admin username for the Amazon MQ RabbitMQ broker"
  value       = var.Amazon-MQ-username
}
output "Amazon-MQ-password" {
  description = "The admin password for the Amazon MQ RabbitMQ broker"
  value       = var.Amazon-MQ-password
}

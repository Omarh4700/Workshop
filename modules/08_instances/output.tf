output "tomcat_public_ip" {
  description = "The public IP address of the Tomcat instance"
  value       = aws_instance.tomcat_instance.public_ip
}

output "ephemeral_worker_public_ip" {
  description = "The public IP address of the Ephemeral Worker instance"
  value       = aws_instance.ephemeral_worker_instance.public_ip
}

output "tomcat_instance_id" {
  description = "The instance ID of the Tomcat instance"
  value       = aws_instance.tomcat_instance.id
}

output "ephemeral_worker_instance_id" {
  description = "The instance ID of the Ephemeral Worker instance"
  value       = aws_instance.ephemeral_worker_instance.id
}
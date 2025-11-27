output "ephemeral_worker_sg_id" {
  description = "The ID of the Ephemeral Worker security group"
  value       = aws_security_group.ephemeral_worker-sg.id
}
output "tomcat_sg_id" {
  description = "The ID of the Tomcat security group"
  value       = aws_security_group.tomcat-sg.id
}
output "clb_sg_id" {
  description = "The ID of the Classic Load Balancer security group"
  value       = aws_security_group.clb-sg.id
}
output "backend_vp_app_sg_id" {
  description = "The ID of the Backend VPC App security group"
  value       = aws_security_group.backend_vp_app_sg.id
}

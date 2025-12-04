output "bastion_public_ip" {
  description = "Bastion host public IP (EIP)"
  value       = module.instances.bastion_public_ip
}
output "jenkins_public_ip" {
  description = "Jenkins public IP"
  value       = module.instances.jenkins_public_ip
}

output "master_private_ip" {
  description = "Master node private IP"
  value       = module.instances.master_private_ip
}

output "worker1_private_ip" {
  description = "Worker 1 private IP"
  value       = module.instances.worker1_private_ip
}

output "worker2_private_ip" {
  description = "Worker 2 private IP"
  value       = module.instances.worker2_private_ip
}

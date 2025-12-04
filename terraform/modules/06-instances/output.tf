output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "master_private_ip" {
  value = aws_instance.master.private_ip
}

output "worker1_private_ip" {
  value = aws_instance.worker[0].private_ip
}

output "worker2_private_ip" {
  value = aws_instance.worker[1].private_ip
}

output "master_id" {
  value = aws_instance.master.id
}

output "worker_ids" {
  value = aws_instance.worker[*].id
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

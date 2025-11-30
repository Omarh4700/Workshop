output "master_ip_private" {
  value = aws_instance.master.private_ip
}

output "worker1_ip_private" {
  value = aws_instance.worker[0].private_ip
}

output "worker2_ip_private" {
  value = aws_instance.worker[1].private_ip
}

output "bastion_ip_public" {
  value = aws_instance.bastion.public_ip
}

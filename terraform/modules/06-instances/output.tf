output "master_ip" {
  value = aws_instance.master.public_ip
}
output "worker_ip" {
  value = aws_instance.worker[*].public_ip
}
output "bastion_ip" {
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
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

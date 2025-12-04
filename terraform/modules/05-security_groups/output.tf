output "master_sg_id" {
  value = aws_security_group.master.id
}

output "worker_sg_id" {
  value = aws_security_group.workers.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion-sg.id
}

output "jenkins_sg_id" {
  value = aws_security_group.jenkins.id
}

output "clb_sg_id" {
  value = aws_security_group.clb.id
}

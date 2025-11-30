output "master_sg_id" {
  value = aws_security_group.master.id
}
output "worker_sg_id" {
  value = aws_security_group.workers.id
}
output "bastion_sg_id" {
  value = aws_security_group.bastion-sg.id
}
variable "igw_id" {
  description = "Internet Gateway ID"
  type        = string
}
variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}
variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
}

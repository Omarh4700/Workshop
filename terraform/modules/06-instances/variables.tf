variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-0c398cb65a93047f2" # Ubuntu 22.04 LTS (us-east-1)
}
variable "master_instance_type" {
  description = "Master instance type"
  type        = string
  default     = "t2.large"
}
variable "worker_instance_type" {
  description = "Worker instance type"
  type        = string
  default     = "t2.medium"
}
variable "bastion_instance_type" {
  description = "Bastion instance type"
  type        = string
  default     = "t2.micro"
}
variable "master_sg_id" {
  description = "Master Security Group ID"
  type        = string
}
variable "worker_sg_id" {
  description = "Worker Security Group ID"
  type        = string
}
variable "bastion_sg_id" {
  description = "Bastion Security Group ID"
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


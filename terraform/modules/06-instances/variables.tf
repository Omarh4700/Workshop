variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-0c398cb65a93047f2" # Ubuntu 22.04 LTS (us-east-1)
}

variable "master_instance_type" {
  description = "Master instance type"
  type        = string
  default     = "t2.large" # 2 vCPU, 8 GB RAM
}

variable "worker_instance_type" {
  description = "Worker instance type"
  type        = string
  default     = "t2.medium" # 2 vCPU, 4 GB RAM *2 = 4 vCPU, 8 GB RAM
}

variable "bastion_instance_type" {
  description = "Bastion instance type"
  type        = string
  default     = "t2.nano" # 1 vCPU, 512 MB RAM
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

variable "jenkins_instance_type" {
  description = "Jenkins instance type"
  type        = string
  default     = "t2.small" # 1 vCPU, 2 GB RAM
}

variable "jenkins_sg_id" {
  description = "Jenkins Security Group ID"
  type        = string
}

variable "jenkins_instance_profile_name" {
  description = "Jenkins IAM instance profile name"
  type        = string
}

variable "jenkins_ebs_size" {
  description = "Size of Jenkins EBS volume in GB"
  type        = number
  default     = 20
}

variable "master_root_volume_size" {
  description = "Size of master root volume in GB"
  type        = number
  default     = 30
}

variable "worker_root_volume_size" {
  description = "Size of worker root volume in GB"
  type        = number
  default     = 30
}

variable "k8s_nodes_instance_profile_name" {
  description = "K8s nodes IAM instance profile name"
  type        = string
}

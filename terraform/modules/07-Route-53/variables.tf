variable "vpc_id" {
  type = string
}
variable "master_private_ip" {
  type = string
}
variable "worker1_private_ip" {
  type = string
}
variable "worker2_private_ip" {
  type = string
}
variable "zone_name" {
  type    = string
  default = "k8s.com"
}
variable "bastion_public_ip" {
  type = string
}

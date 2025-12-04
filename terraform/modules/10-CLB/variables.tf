variable "grafana_clb_name" {
  type        = string
  default     = "grafana-clb"
  description = "Name of the Grafana CLB"
}

variable "tomcat_clb_name" {
  type        = string
  default     = "tomcat-clb"
  description = "Name of the Tomcat CLB"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnets to place the CLB in"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security groups for the CLB"
}

variable "instances" {
  type        = list(string)
  description = "List of instance IDs to attach to the CLB"
}

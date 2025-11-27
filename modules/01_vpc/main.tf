resource "aws_vpc" "vp-app_VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vp-app_VPC"
  }
  
}
resource "aws_internet_gateway" "vp-app_IGW" {
  vpc_id              = aws_vpc.vp-app_VPC.id
  tags = {
    Name              = "vp-app_IGW"
  }
}

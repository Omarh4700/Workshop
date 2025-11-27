resource "aws_subnet" "public_subnet-A" {
  vpc_id                   = var.vpc_id
  cidr_block               = var.public_subnet_cidr
  availability_zone        = var.availability_zone-A
  map_public_ip_on_launch  = true
  tags = {
    Name                   = "Public_Subnet-A"
  }
}

resource "aws_subnet" "public_subnet-B" {
  vpc_id                   = var.vpc_id
  cidr_block               = var.public_subnet_cidr-B
  availability_zone        = var.availability_zone-B
  map_public_ip_on_launch  = true
  tags = {
    Name                   = "Public_Subnet-B"
  }
}

resource "aws_subnet" "private_subnet-A" {
  vpc_id                   = var.vpc_id
  cidr_block               = var.private_subnet_cidr-A
  availability_zone        = var.availability_zone-A
  tags = {
    Name                   = "Private_Subnet-A"
  }
}

resource "aws_subnet" "private_subnet-B" {
  vpc_id                   = var.vpc_id
  cidr_block               = var.private_subnet_cidr-B
  availability_zone        = var.availability_zone-B
  tags = {
    Name                   = "Private_Subnet-B"
  }
}
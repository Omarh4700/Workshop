# Create Route Table >> Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id           = var.vpc_id
  tags = {
    Name           = "Public_Route_Table"
  }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.aws_internet_gateway_id
}
}
# Associate Public Subnets with Public public_subnet-A public_subnet-B
resource "aws_route_table_association" "public_subnet-A" {
  subnet_id        = var.public_subnet-A-id
  route_table_id   = aws_route_table.public_rt.id 
}

resource "aws_route_table_association" "public_subnet-B" {
  subnet_id        = var.public_subnet-B-id
  route_table_id   = aws_route_table.public_rt.id 
}
 
# Private Route Table > Local
resource "aws_route_table" "private_rt" {
  vpc_id           = var.vpc_id
  tags = {
    Name           = "Private_Route_Table"
  }
}
# Create Route Table >> Private Subnet_A  Private Subnet_B
resource "aws_route_table_association" "private_rt_association_A" {
  subnet_id        = var.private_subnet_A_id
  route_table_id   = aws_route_table.private_rt.id 
}

resource "aws_route_table_association" "private_rt_association_B" {
  subnet_id        = var.private_subnet_B_id
  route_table_id   = aws_route_table.private_rt.id 
}
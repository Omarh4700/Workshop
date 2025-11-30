resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = {
    Name = "public_route_table"
  }
}
# Public Route Table --> Internet Gateway
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}
# Associate Public Subnet with Route Table >> public-igw
resource "aws_route_table_association" "public" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public.id
}
# Private Route Table --> NAT Gateway
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.natgw_id
  }
  tags = {
    Name = "private_route_table"
  }
}
# Associate Private Subnet with Route Table >> private-nat
resource "aws_route_table_association" "private" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private.id
}

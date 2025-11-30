resource "aws_eip" "natgw_eip" {
  tags = {
    Name = "natgw_eip"
  }
}
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id     = var.public_subnet_id
  tags = {
    Name = "natgw"
  }
}

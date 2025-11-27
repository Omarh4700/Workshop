output "public_rt_id" {
    description = "The ID of the public route table"
    value = aws_route_table.public_rt.id

}
output "public_subnet-A-rt" {
    description = "The ID of the route table association for public subnet A"
    value = aws_route_table_association.public_subnet-A.id
}
output "public_subnet-B-rt" {
    description = "The ID of the route table association for public subnet B"
    value = aws_route_table_association.public_subnet-B.id
}
output "private_rt_id" {
    description = "The ID of the Private route table"
    value = aws_route_table.private_rt.id
}
output "private_subnet-A-rt" {
    description = "The ID of the route table association for public subnet A"
    value = aws_route_table_association.private_rt_association_A.id
}
output "private_subnet-B-rt" {
    description = "The ID of the route table association for public subnet B"
    value = aws_route_table_association.private_rt_association_B.id
}
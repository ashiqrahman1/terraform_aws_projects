output "this_vpc_id" {
  value = aws_vpc.main.id
}

output "this_vpc_public_subnet" {
  value = aws_subnet.public_subnet[*].cidr_block
}

output "this_vpc_public_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}

output "this_vpc_private_subnet" {
  value = aws_subnet.private_subnet[*].cidr_block
}

output "this_vpc_private_subnet_id" {
  value = aws_subnet.private_subnet[*].id
}


output "this_vpc_db_subnet" {
  value = aws_subnet.db_subnet[*].cidr_block
}
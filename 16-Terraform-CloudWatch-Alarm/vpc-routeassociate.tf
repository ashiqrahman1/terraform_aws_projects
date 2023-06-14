// Associating Subnets and Route Table (Public Subnets)
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.pub2.id
  route_table_id = aws_route_table.public.id
}


// Assocaite Subnets and Route Tables (Private Subnet)
resource "aws_route_table_association" "app1" {
  subnet_id      = aws_subnet.app1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "app2" {
  subnet_id      = aws_subnet.app2.id
  route_table_id = aws_route_table.private.id
}

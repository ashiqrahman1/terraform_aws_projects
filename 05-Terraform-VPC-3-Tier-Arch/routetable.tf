resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "PublicRT"
  }
}

resource "aws_route_table_association" "PublicRT1" {
  subnet_id      = aws_subnet.public1_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "PublicRT2" {
  subnet_id      = aws_subnet.public2_az2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    Name = "PrivateRT"
  }
}

resource "aws_route_table_association" "PrivateRT1" {
  subnet_id      = aws_subnet.private1_az1.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateRT2" {
  subnet_id      = aws_subnet.private2_az2.id
  route_table_id = aws_route_table.PrivateRT.id
}

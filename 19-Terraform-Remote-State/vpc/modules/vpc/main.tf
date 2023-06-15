
#######################################################################
# VPC
#######################################################################
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "${var.vpc_name}"
  }
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

#######################################################################
# Adding IGW to VPC
#######################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id  = aws_vpc.main.id
  tags = {
    Name = "IGW"
  }
}

#######################################################################
# Public Subnet
#######################################################################
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnet,count.index)
  availability_zone = element(var.az,count.index)
}

#######################################################################
# Private Subnet
#######################################################################
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet,count.index)
  availability_zone = element(var.az,count.index)
}

#######################################################################
# Database Subnet
#######################################################################
resource "aws_subnet" "db_subnet" {
  count = length(var.database_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.database_subnet,count.index)
  availability_zone = element(var.az,count.index)
}

#######################################################################
# Setup EIP
#######################################################################
resource "aws_eip" "nat_eip"{
  vpc = true
}

#######################################################################
# Setup NAT GATEWAY
#######################################################################
resource "aws_nat_gateway" "NGW" {
  # count = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet[1].id
  depends_on = [ aws_internet_gateway.igw ]
}

#######################################################################
# Setup Public RouteTable
#######################################################################
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#######################################################################
# Setup Private RouteTable
#######################################################################
resource "aws_route_table" "privateRT" {
  # count = var.enable_nat_gateway ? 1 : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NGW.id
  }
}

#######################################################################
# Setup Public RouteTable Association
#######################################################################
resource "aws_route_table_association" "publicRTAssociate" {
  count = length(var.public_subnet)
  subnet_id  = element(aws_subnet.public_subnet[*].id,count.index)
  route_table_id = aws_route_table.publicRT.id
  # tags = {
  #   Name = "PublicRT-${count.index}"
  # }
}

#######################################################################
# Setup Private RouteTable Association
#######################################################################
resource "aws_route_table_association" "privateRTAssociate" {
  # count = var.enable_nat_gateway ? length(var.private_subnet) : 0
  count = length(var.private_subnet)
  subnet_id  = element(aws_subnet.private_subnet[*].id,count.index)
  route_table_id = aws_route_table.privateRT.id
  # tags = {
  #   Name = "Private-${count.index}"
  # }
}

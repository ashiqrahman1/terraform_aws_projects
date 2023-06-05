// creating VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    Name = "VPC"
  }
}

// creating internet gateway and attach to vpc
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id
}

// create EIP
resource "aws_eip" "eip_1" {
  vpc = true
}

# resource "aws_eip" "eip_2" {
#   vpc = true
# }

// create natgateway in az1
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip_1.id
  subnet_id     = aws_subnet.public1_az1.id
  depends_on    = [aws_internet_gateway.main_igw]
}


# // create natgateway in az2
# resource "aws_nat_gateway" "natgw2" {
#   allocation_id = aws_eip.eip_2.id
#   subnet_id     = aws_subnet.public2_az2.id
#   depends_on    = [aws_internet_gateway.main_igw]
# }

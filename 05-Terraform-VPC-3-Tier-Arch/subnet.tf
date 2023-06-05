// create public-1 in az-1
resource "aws_subnet" "public1_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public1"
  }
}

// create public subnet in az-2
resource "aws_subnet" "public2_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public2"
  }
}

// create private subnet in az-1
resource "aws_subnet" "private1_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr1
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "Private1"
  }
}

// create private subnet in az-2
resource "aws_subnet" "private2_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr2
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Private2"
  }
}

// create DB subnet in AZ-1
resource "aws_subnet" "db1_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_cidr1
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "db1"
  }
}

resource "aws_subnet" "db2_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_cidr2
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "db2"
  }
}

// public subnets
resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub1
  availability_zone       = data.aws_availability_zones.az.names[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub2
  availability_zone       = data.aws_availability_zones.az.names[1]
  map_public_ip_on_launch = true
}

// private subnets [APPS]

resource "aws_subnet" "app1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app1
  availability_zone = data.aws_availability_zones.az.names[0]
}

resource "aws_subnet" "app2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app2
  availability_zone = data.aws_availability_zones.az.names[1]
}

// DB subnets

resource "aws_subnet" "db1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db1
  availability_zone = data.aws_availability_zones.az.names[0]
}

resource "aws_subnet" "db2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db2
  availability_zone = data.aws_availability_zones.az.names[1]
}


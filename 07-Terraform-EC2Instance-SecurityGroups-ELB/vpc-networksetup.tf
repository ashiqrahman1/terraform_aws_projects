resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Env = "${var.department}-${var.env}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.pub1.id
  depends_on    = [aws_internet_gateway.igw]
}


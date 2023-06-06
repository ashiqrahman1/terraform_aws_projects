resource "aws_security_group" "elb_sg" {
  name        = var.elb_sg_name
  description = "Allow SSH connection from any where"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.elb_ingress
    to_port     = var.elb_ingress
    cidr_blocks = var.elb_cidrblock
    protocol    = "tcp"
  }

  ingress {
    from_port = 81
    to_port = 81
    cidr_blocks = var.elb_cidrblock
    protocol = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.elb_cidrblock
  }
}
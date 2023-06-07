resource "aws_security_group" "bastion" {
  name        = var.bastion_sg
  description = "Allow SSH connection from any where"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.ingress_bastion
    to_port     = var.ingress_bastion
    cidr_blocks = var.bastion_cidr
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.bastion_cidr
  }
}

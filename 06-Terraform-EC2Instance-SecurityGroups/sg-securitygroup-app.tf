
resource "aws_security_group" "app" {
  name        = var.app_sg
  description = "Allow SSH connection Bastion Hosts"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = var.ingress_app
    to_port         = var.ingress_app
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.app_cidr
  }

  #   depends_on = [aws_security_group.bastion]
}
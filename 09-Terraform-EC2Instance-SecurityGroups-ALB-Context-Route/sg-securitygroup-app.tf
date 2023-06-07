
resource "aws_security_group" "app" {
  name        = var.app_sg
  description = "Allow SSH connection Bastion Hosts and CLB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH from Bastion"
    from_port       = var.ingress_app
    to_port         = var.ingress_app
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
  ingress {
    from_port = var.ingress_app_http
    to_port = var.ingress_app_http
    protocol = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # ingress {
  #   from_port = 443
  #   to_port = 443
  #   protocol = "tcp"
  #   security_groups = [aws_security_group.alb_sg.id]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.app_cidr
  }

  depends_on = [aws_security_group.bastion]
}

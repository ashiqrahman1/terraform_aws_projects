
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
    description = "Allow HTTP from Load Balancer"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }

  ingress {
    from_port = var.ingress_app_http
    to_port = var.ingress_app_http
    protocol = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.app_cidr
  }

  depends_on = [aws_security_group.bastion]
}

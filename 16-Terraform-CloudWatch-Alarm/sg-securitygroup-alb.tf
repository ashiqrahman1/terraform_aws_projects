resource "aws_security_group" "alb_sg" {
  # count = length(var.alb_info)
  name        = var.alb_name
  description = "Allow HTTP from Any Where"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTPS from Any Where"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP Communication"
    from_port   = var.alb_from_port
    to_port     = var.alb_to_port
    protocol    = "tcp"
    cidr_blocks = var.alb_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.app_cidr
  }

  #   depends_on = [aws_security_group.bastion]
}
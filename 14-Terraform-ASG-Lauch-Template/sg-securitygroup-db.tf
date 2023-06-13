resource "aws_security_group" "db_sg" {
  name = var.db_sg_name
  description = "Allow MySQL connection from App SG"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow MySQL Connection"
    from_port = var.db_ingress
    to_port = var.db_ingress
    protocol = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
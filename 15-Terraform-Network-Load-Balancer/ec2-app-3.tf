# resource "aws_instance" "app3_sub1" {
#   ami             = "ami-09988af04120b3591"
#   instance_type   = var.instance_type
#   subnet_id       = aws_subnet.app1.id
#   security_groups = [aws_security_group.app.id]
#   tags = {
#     Name = "APP3-${var.department}"
#   }
#   key_name   = aws_key_pair.sshkey.key_name
#   depends_on = [aws_nat_gateway.ngw]
#   user_data  = file("${path.module}/app3.sh")
# }

# resource "aws_instance" "app3_sub2" {
#   ami             = "ami-09988af04120b3591"
#   instance_type   = var.instance_type
#   subnet_id       = aws_subnet.app2.id
#   security_groups = [aws_security_group.app.id]
#   tags = {
#     Name = "APP3-${var.department}"
#   }
#   key_name   = aws_key_pair.sshkey.key_name
#   depends_on = [aws_nat_gateway.ngw]
#   user_data  = file("${path.module}/app3.sh")
# }
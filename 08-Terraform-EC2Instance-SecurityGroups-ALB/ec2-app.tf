resource "aws_instance" "app1" {
  ami             = data.aws_ssm_parameter.ami.value
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.app1.id
  security_groups = [aws_security_group.app.id]
  tags = {
    Name = "${var.app_instance_name}"
  }
  key_name = aws_key_pair.sshkey.key_name
  depends_on = [ aws_nat_gateway.ngw,aws_route_table_association.app1 ]
  user_data = file("${path.module}/httpd.sh")
}

resource "aws_instance" "app2" {
  ami             = data.aws_ssm_parameter.ami.value
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.app2.id
  security_groups = [aws_security_group.app.id]
  tags = {
    Name = "${var.app_instance_name}"
  }
  key_name = aws_key_pair.sshkey.key_name
  depends_on = [ aws_nat_gateway.ngw,aws_route_table_association.app2 ]
  user_data = file("${path.module}/httpd.sh")
}

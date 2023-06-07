resource "aws_instance" "app1_sub1" {
  ami             = data.aws_ssm_parameter.ami.value
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.app1.id
  security_groups = [aws_security_group.app.id]
  tags = {
    Name = "${var.app1_instance_name}-${var.department}"
  }
  key_name = aws_key_pair.sshkey.key_name
  depends_on = [ aws_nat_gateway.ngw ]
  user_data = file("${path.module}/app1.sh")
}

resource "aws_instance" "app1_sub2" {
  ami             = data.aws_ssm_parameter.ami.value
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.app2.id
  security_groups = [aws_security_group.app.id]
  tags = {
    Name = "${var.app1_instance_name}-${var.department}"
  }
  key_name = aws_key_pair.sshkey.key_name
  depends_on = [ aws_nat_gateway.ngw ]
  user_data = file("${path.module}/app1.sh")
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ssm_parameter.ami.value
  instance_type = var.instance_type
  subnet_id     = aws_subnet.pub2.id
  tags = {
    Name = "${var.bastion_instance_name}"
  }
  security_groups = [aws_security_group.bastion.id]
  key_name        = aws_key_pair.sshkey.key_name
}

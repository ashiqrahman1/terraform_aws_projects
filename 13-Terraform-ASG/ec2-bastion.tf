resource "aws_instance" "bastion" {
  ami           = data.aws_ssm_parameter.ami.value
  instance_type = var.instance_type
  subnet_id     = aws_subnet.pub2.id
  tags = {
    Name = "${var.bastion_instance_name}"
  }
  # security_groups = [aws_security_group.bastion.id]
  vpc_security_group_ids =  [aws_security_group.bastion.id]
  key_name        = aws_key_pair.sshkey.key_name
  # lifecycle {
  #   ignore_changes = [
  #     disable_api_termination,ebs_optimized,hibernation,security_groups,
  #     credit_specification,network_interface,ephemeral_block_device]
  # }
}

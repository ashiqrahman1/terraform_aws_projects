# resource "aws_launch_configuration" "asg_template" {
#   name = var.asg_name
#   image_id = data.aws_ssm_parameter.ami.value
#   instance_type = var.instance_type
#   user_data = file("${path.module}/asg.sh")
#   security_groups = [ aws_security_group.app.id ]
#   depends_on = [ aws_nat_gateway.ngw ]
# }

resource "aws_launch_template" "myTemp" {
  name = "terraform-template-tf"
  image_id = data.aws_ssm_parameter.ami.value
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.app.id ]
  user_data = filebase64("${path.module}/asg.sh")
  key_name = aws_key_pair.sshkey.key_name
  ebs_optimized = true
  update_default_version = true
}
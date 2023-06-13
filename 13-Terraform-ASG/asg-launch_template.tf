resource "aws_launch_configuration" "asg_template" {
  name = var.asg_name
  image_id = data.aws_ssm_parameter.ami.value
  instance_type = var.instance_type
  user_data = file("${path.module}/asg.sh")
  security_groups = [ aws_security_group.app.id ]
  depends_on = [ aws_nat_gateway.ngw ]
}
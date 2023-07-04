data "aws_ssm_parameter" "my-amzn-linux-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnet" "subnets" {
  count = length(var.subnet_id)
  id    = element(var.subnet_id, count.index)
}

data "aws_security_group" "sg" {
  id = var.sg_id
}
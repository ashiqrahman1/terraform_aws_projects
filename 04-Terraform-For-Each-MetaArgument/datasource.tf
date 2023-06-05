
data "aws_ssm_parameter" "my-amzn-linux-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "aws_vpc" "main" {
  default = true
}

data "aws_availability_zones" "az" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


data "aws_ec2_instance_type_offerings" "example" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [for az in data.aws_availability_zones.az.names : az]
  }
  location_type = "availability-zone"
}

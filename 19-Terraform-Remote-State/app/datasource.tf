data "terraform_remote_state" "vpc"{
    backend = "s3"
    config = {
        bucket = "ashiqrahman-tf-bucket-test1231212"
        key = "dev/vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}
terraform {
  backend "s3" {
    bucket = "ashiqrahman-tf-bucket-test1231212"
    key = "dev/appsetup/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform_state"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.3.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}


module "appsetup" {
    source = "./modules/albsetup"
    load_balancer_name = "ashikALB"
    load_balancer_type = "application"
    internal = false
    subnets = data.terraform_remote_state.vpc.outputs.public_subnets_id
    target_group_name = "myTG"
    target_group_port = 80
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    health_check_path = "/"
    health_check_protocol = "HTTP"
}
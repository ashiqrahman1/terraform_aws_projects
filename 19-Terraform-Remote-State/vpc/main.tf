terraform {
  backend "s3" {
    bucket = "ashiqrahman-tf-bucket-test1231212"
    key = "dev/vpc/terraform.tfstate"
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

module "vpc" {
    source = "./modules/vpc"
    vpc_name = "Module-VPC-TF"
    vpc_cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    az = ["us-east-1a","us-east-1b"]
    public_subnet = ["10.0.101.0/24","10.0.102.0/24"]
    private_subnet = ["10.0.1.0/24","10.0.2.0/24"]
    database_subnet = ["10.0.151.0/24","10.0.152.0/24"]
    enable_nat_gateway = true
}
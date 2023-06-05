variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}


variable "instance_type_list" {
  type    = list(string)
  default = ["t2.micro", "t3.micro"]
}

variable "instance_type_map" {
  type = map(string)
  default = {
    "prod" = "t2.small"
    "dev"  = "t2.nano"
    "ua1"  = "t2.micro"
  }
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

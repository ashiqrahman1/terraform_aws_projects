variable "bastion_instance_name" {
  type    = string
  default = "BastionHost"
}

variable "app1_instance_name" {
  type    = string
  default = "AppInstance-APP1"
}

variable "app2_instance_name" {
  type    = string
  default = "AppInstance-APP2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

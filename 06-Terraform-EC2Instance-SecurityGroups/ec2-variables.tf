variable "bastion_instance_name" {
  type    = string
  default = "BastionHost"
}

variable "app_instance_name" {
  type    = string
  default = "AppInstance"
}
variable "instance_type" {
  type = string
}

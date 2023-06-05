variable "bastion_sg" {
  type    = string
  default = "bastion-sg"
}

variable "bastion_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ingress_bastion" {
  type    = number
  default = 22
}

variable "app_sg" {
  type    = string
  default = "app_sg"
}

variable "ingress_app" {
  type    = number
  default = 22
}

variable "app_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

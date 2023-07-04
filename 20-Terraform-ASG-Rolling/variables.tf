variable "vpc_id" {
  type    = string
  default = "vpc-0ca9dc2ab937fbfe0"
}

variable "subnet_id" {
  type    = list(string)
  default = ["subnet-09710a63c77261a19", "subnet-0f80b1d2056fec3b8", "	subnet-0fb3f7b3dc5b8b0f9"]
}

variable "sg_id" {
  type    = string
  default = "sg-090f67ce7a49efec2"
}

variable "autscale_min" {
  type    = number
  default = 1
}

variable "autoscale_max" {
  type    = number
  default = 4
}

variable "autoscale_desire" {
  type    = number
  default = 2
}
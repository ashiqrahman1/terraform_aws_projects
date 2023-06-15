variable "vpc_name" {
    type = string
    default = "VPC-TF"
}

variable "vpc_cidr_block" {
    type  = string
    default = null
}

variable "enable_dns_support" {
    type = bool
    default = true
}

variable "enable_dns_hostnames" {
    type = bool
    default = false
}

variable "az" {
    type = list(string)
    default = null
}

variable "public_subnet" {
    type = list(string)
    default = null
}

variable "private_subnet" {
  type = list(string)
  default = null
}

variable "database_subnet" {
  type = list(string)
  default = null
}

variable "enable_nat_gateway" {
  type = bool
  default = true
}
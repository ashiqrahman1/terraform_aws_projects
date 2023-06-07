variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "pub1" {
  type    = string
  default = "10.0.2.0/24"
}

variable "pub2" {
  type    = string
  default = "10.0.4.0/24"
}

variable "app1" {
  type    = string
  default = "10.0.6.0/24"
}

variable "app2" {
  type    = string
  default = "10.0.8.0/24"
}

variable "db1" {
  type    = string
  default = "10.0.10.0/24"
}

variable "db2" {
  type    = string
  default = "10.0.12.0/24"
}

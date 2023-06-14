variable "rds_name" {
  type = string
  default = "terraform"
}

variable "db_instance" {
  type = string
  default = "db.t3.micro"
}

variable "db_size" {
  type = number
  default = 20
}

variable "db_user" {
  type = string 
}

variable "db_pass" {
  type = string
}

variable "db_name" {
  type = string
}
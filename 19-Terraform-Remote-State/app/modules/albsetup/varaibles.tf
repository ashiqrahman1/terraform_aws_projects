variable "load_balancer_name" {
    type = string
    default = "Terraform-Load-Balancer"
}

variable "load_balancer_type" {
    type = string
    default = null
}

variable "internal" {
    type = bool
    default = false
}

variable "subnets" {
    type = list(string)
    default = null
}

variable "target_group_name" {
    type = string
    default = "Terraform-TG"
}

variable "target_group_port" {
    type = number
    default = 80
}

variable "vpc_id" {
    type = string
    default = null
}

variable "target_group_protocol" {
    type = string
    default = "HTTP"
}

variable "health_check_path" {
    type = string
    default = "/"
}

variable "health_check_protocol" {
    type = string
    default = "HTTP"
}
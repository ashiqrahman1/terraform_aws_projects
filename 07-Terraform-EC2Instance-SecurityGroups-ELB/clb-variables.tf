variable "elb_sg_name" {
    type = string
    default = "myelb"
}

variable "elb_ingress" {
    type = number
    default = 80
}

variable "elb_cidrblock" {
    type = list(string)
    default = ["0.0.0.0/0"]
}
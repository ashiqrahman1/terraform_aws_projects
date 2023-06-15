variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "image_id" {
    type = string
    default = null
}

variable "asg_name" {
    type = string 
    default = "ASG-TF"
}
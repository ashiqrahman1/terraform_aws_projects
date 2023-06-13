variable "loadbalance_name" {
  type    = string
  default = "myalb"
}

variable "target_group_1" {
  type    = string
  default = "tgzApp1"
}

variable "target_group_2" {
  type    = string
  default = "tgzApp2"
}

variable "tg_port" {
  type    = number
  default = 80
}

# variable "alb_info" {
#     type = list(object({
#         name = string
#         from_port = number
#         to_port = number
#         protocol = string
#         cidr_blocks = list(string)
#     }))

#     default = [{
#         name = "alb_sg"
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }]
# }

variable "alb_name" {
  type    = string
  default = "alb_sg"
}

variable "alb_from_port" {
  type    = number
  default = 80
}

variable "alb_to_port" {
  type    = number
  default = 80
}

variable "alb_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
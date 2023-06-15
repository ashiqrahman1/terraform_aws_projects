resource "aws_lb" "myALB" {
    name = var.load_balancer_name
    internal = var.internal
    load_balancer_type  = var.load_balancer_type
    subnets = var.subnets
    tags = {
        Name = "Terraform_TF"
    }
}

resource "aws_lb_target_group" "target_group" {
  name = var.target_group_name
  port = var.target_group_port
  vpc_id = var.vpc_id
  protocol = var.target_group_protocol
  health_check {
    path = var.health_check_path
    protocol = var.health_check_protocol
  }
}
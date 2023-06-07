locals {
    instance_id = [aws_instance.app1.id,aws_instance.app2.id]
}

// creating application load balancer

resource "aws_lb" "app_loadbalance"{
    name = var.loadbalance_name
    internal = false
    load_balancer_type = "application"
    subnets = [aws_subnet.pub1.id, aws_subnet.pub2.id]
    security_groups = [ aws_security_group.alb_sg.id ]
}

// create target group

resource "aws_lb_target_group" "app_loadbalancer_tg" {
  name = var.target_group
  port = var.tg_port
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  health_check {
    path = "/"
    protocol = "HTTP"
  }
}

// attach instance to tg
resource "aws_alb_target_group_attachment" "app_loadbalancer_attach" {
    count = length(local.instance_id)
    target_group_arn  = aws_lb_target_group.app_loadbalancer_tg.arn
    target_id = element(local.instance_id,count.index)
}

// alb listner

resource "aws_lb_listener" "forward" {
    load_balancer_arn  = aws_lb.app_loadbalance.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.app_loadbalancer_tg.arn
    }
}
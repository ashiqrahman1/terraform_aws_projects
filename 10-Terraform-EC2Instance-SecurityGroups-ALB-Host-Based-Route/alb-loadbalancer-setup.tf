locals {
  tg1 = [aws_instance.app1_sub1.id, aws_instance.app1_sub2.id]
  tg2 = [aws_instance.app2_sub1.id, aws_instance.app2_sub2.id]
}

// creating application load balancer

resource "aws_lb" "app_loadbalance" {
  name               = var.loadbalance_name
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.pub1.id, aws_subnet.pub2.id]
  security_groups    = [aws_security_group.alb_sg.id]
}

// create target_group_1

resource "aws_lb_target_group" "app_loadbalancer_tg1" {
  name     = var.target_group_1
  port     = var.tg_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    path     = "/"
    protocol = "HTTP"
    matcher  = "200-399"
  }
}

// create target_group_2

resource "aws_lb_target_group" "app_loadbalancer_tg2" {
  name     = var.target_group_2
  port     = var.tg_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    path     = "/"
    protocol = "HTTP"
    matcher  = "200-399"
  }
}

// attach instance to tg1
resource "aws_alb_target_group_attachment" "tg1_loadbalancer_attach" {
  count            = length(local.tg1)
  target_group_arn = aws_lb_target_group.app_loadbalancer_tg1.arn
  target_id        = element(local.tg1, count.index)
}

// Attach Instance in tg2

resource "aws_alb_target_group_attachment" "tg2_loadbalancer_attach" {
  count            = length(local.tg2)
  target_group_arn = aws_lb_target_group.app_loadbalancer_tg2.arn
  target_id        = element(local.tg2, count.index)
}


// create listner cert

# resource "aws_lb_listener_certificate" "cert" {
#   listener_arn    = aws_lb_listener.https_listner.arn
#   certificate_arn = aws_acm_certificate.test.arn
# }

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_loadbalance.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listner" {
  load_balancer_arn = aws_lb.app_loadbalance.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate_validation.validation.certificate_arn
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed Response content"
      status_code  = "200"
    }
  }

  # condition {
  #   host_header {
  #     values = join(".", [var.default, var.domain_name])
  #   }
  # }
}

resource "aws_lb_listener_rule" "default_rule" {
  listener_arn = aws_lb_listener.https_listner.arn
  action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed Response content"
      status_code  = "200"
    }
  }

  condition {
    host_header {
      values = ["${var.default}.${var.domain_name}"]
      # values = []
    }
  }
}

resource "aws_lb_listener_rule" "app1_rule" {
  listener_arn = aws_lb_listener.https_listner.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_loadbalancer_tg1.arn
  }

  condition {
    host_header {
      values = ["${var.app1_domain}.${var.domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "app2_rule" {
  listener_arn = aws_lb_listener.https_listner.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_loadbalancer_tg2.arn
  }

  condition {
    host_header {
      values = ["${var.app2_domain}.${var.domain_name}"]
    }
  }
}
// alb listner for tg1 

# resource "aws_lb_listener" "tg1" {
#     load_balancer_arn  = aws_lb.app_loadbalance.arn
#     port = "80"
#     protocol = "HTTP"

#     default_action {
#         type = "forward"
#         target_group_arn = aws_lb_target_group.app_loadbalancer_tg1.arn
#     }
# }

# // alb listner for tg2

# resource "aws_lb_listener" "tg2" {
#     load_balancer_arn  = aws_lb.app_loadbalance.arn
#     port = "80"
#     protocol = "HTTP"

#     default_action {
#         type = "forward"
#         target_group_arn = aws_lb_target_group.app_loadbalancer_tg2.arn
#     }
# }


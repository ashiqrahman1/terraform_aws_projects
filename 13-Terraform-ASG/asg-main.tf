resource "aws_autoscaling_group" "asg" {
  name = "terraform-asg"
  launch_configuration = aws_launch_configuration.asg_template.name
  min_size = 1
  max_size = 5
  desired_capacity = 3
  vpc_zone_identifier = [ aws_subnet.app1.id,aws_subnet.app2.id ]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }
}

resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn = aws_lb_target_group.app_loadbalancer_tg1.arn
}

resource "aws_autoscaling_notification" "asg_notify" {
  group_names = [ aws_autoscaling_group.asg.name ]
  notifications = [ 
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE"
   ]

   topic_arn = aws_sns_topic.asg_topic.arn
}

resource "aws_autoscaling_policy" "cpu_utilize" {
  name = "AvgCPU"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
#   cooldown = 300
}

# resource "aws_autoscaling_policy" "alb_request_count" {
#   name = "ALB-REQ-COUNT"
#   autoscaling_group_name = aws_autoscaling_group.asg.name
#   policy_type = "TargetTrackingScaling"
#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ALBRequestCountPerTarget"
#     }
#     target_value = 50.0
#   }
# #   cooldown = 300
# }

# resource "aws_autoscaling_policy" "alb" {}

resource "aws_autoscaling_schedule" "schedule_scale" {
  scheduled_action_name  = "schedule_scale"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 4
  start_time             = "2023-12-11T18:00:00Z"
  recurrence = "00 09 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}
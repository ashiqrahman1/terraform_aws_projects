// simple scaling policy for ASG
resource "aws_autoscaling_policy" "cpu_utilize" {
  name  = "example-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown = 50
}


// simple scaling 
resource "aws_cloudwatch_metric_alarm" "cloudwatch" {
  alarm_name          = "terraform-cloudwatch-tf"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.cpu_utilize.arn]
}

# alb request
resource "aws_autoscaling_policy" "alb_request_count" {
  name = "alb-count"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown = 50
}

// alb simple scaling

resource "aws_cloudwatch_metric_alarm" "alb_cloudwatch" {
  alarm_name          = "terraform-cloudwatch-alb-tf"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 120
  statistic           = "Average"
  threshold           = 100

  dimensions = {
    LoadBalancer = aws_lb.app_loadbalance.arn_suffix
  }

  alarm_description = "This metric monitors alb 4XX"
  ok_actions = [aws_sns_topic.asg_topic.arn]
  alarm_actions     = [aws_autoscaling_policy.alb_request_count.arn]
}
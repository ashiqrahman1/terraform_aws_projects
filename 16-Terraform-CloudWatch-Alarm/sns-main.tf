resource "aws_sns_topic" "asg_topic" {
  name = "terraform-asg-topic"
}

resource "aws_sns_topic_subscription" "asg_sub" {
  topic_arn = aws_sns_topic.asg_topic.arn
  protocol = "email"
  endpoint = "rifani7793@bodeem.com"
}
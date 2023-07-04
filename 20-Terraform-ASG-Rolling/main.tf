resource "aws_key_pair" "ssh" {
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdXWiCZ1G6byx0CjMQOZezie5lxEXrPZr6F94SOKjUrA0lR+IDjs8EJJd5UpDgwc+ToM7nEInbKf6fmR0DmOjwrVLZlJbQGK7nFP6eV3NewsI34RLOvwIsCs0JM86slCVJMdoykYH2r8+ZVLkasNwqJULW0eCwR3oyCHUC89bhVS4GYAH2y+2AMPQ2zCNQYJgqhDukwFPLJAZiKOHRx9cJ3gskkixeB4LBvIYoJv0glL07OQ3dgcKtxJnN4UmESQ65miI24ZJTRPxHFZBenrGW8muIh/j5I1qok6q9M70QTWZItlJw+25yscoWWNbE5XeA31tVpZKGGdr6z/vdCCZWelsreEZEzyQunb16HB1JJKs4mTDnAd5yidVQn7A9WOUND71TDGjwXUCDI/P+17IhMNom7c7aFrRYbib7KEVT22+amei+g32mE8nrVhmLY0Du6+ZR5G16g1TO34xlzrPVZb9ciJeVWvs1Z1jDxGBBMclqixyJrszk3/f0Sc5xa1k= ashiq@linuxmint"
  key_name   = "terraform"
}

resource "aws_launch_template" "myTemp" {
  name                   = "mytemplate"
  image_id               = data.aws_ssm_parameter.my-amzn-linux-ami.value
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [data.aws_security_group.sg.id]
#   user_data              = filebase64("./httpd.sh")
}

resource "aws_autoscaling_group" "asg" {
  name = "auto-scaling"
  max_size = var.autoscale_max
  min_size = var.autscale_min
  desired_capacity = var.autoscale_desire
  vpc_zone_identifier = [ data.aws_subnet.subnets[0].id,data.aws_subnet.subnets[1].id,data.aws_subnet.subnets[2].id ]
  launch_template {
    id = aws_launch_template.myTemp.id
  }
}

# resource "aws_autoscaling_policy" "bat" {
#   name                   = "foobar3-terraform-test"
#   scaling_adjustment     = 4
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = aws_autoscaling_group.asg.name
# }
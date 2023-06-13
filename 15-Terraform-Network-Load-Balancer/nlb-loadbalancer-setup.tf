resource "aws_lb" "name" {
  name = "terraform-nlb-tf"
  internal = false
  load_balancer_type = "network"
  subnets = [ aws_subnet.pub1.id,aws_subnet.pub2.id ]
  tags = {
    Name = "NLB-TF"
  }
}
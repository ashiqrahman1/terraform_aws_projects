###########################################
# Load Balancer ARN
###########################################

output "this_loadbalancer_arn" {
    value = aws_lb.myALB.arn
}

###########################################
# Load Balancer ARN SUFFIX
###########################################

output "this_loadbalancer_arn_suffix" {
    value = aws_lb.myALB.arn_suffix
}

###########################################
# Load Balancer DNS
###########################################

output "this_loadbalancer_dns" {
    value = aws_lb.myALB.dns_name
}

###########################################
# Target Group ARN
###########################################
output "this_target_group_arn" {
    value = aws_lb_target_group.target_group.arn
}

###########################################
# Target Group ARN SUFFIX
###########################################
output "this_target_group_arn_suffix" {
    value = aws_lb_target_group.target_group.arn_suffix
}

###########################################
# Target Group ID
###########################################
output "this_target_group_id" {
    value = aws_lb_target_group.target_group.id
}

###########################################
# Target Group NAME
###########################################
output "this_target_group_name" {
    value = aws_lb_target_group.target_group.name
}
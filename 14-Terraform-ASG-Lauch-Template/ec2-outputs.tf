output "ec2_bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

# output "ec2_app_private_ip" {
#   value = tolist([aws_instance.app1.private_ip, aws_instance.app2.private_ip])
# }

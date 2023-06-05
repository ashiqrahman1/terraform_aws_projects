// looping list 
# output "ec2_public_ip" {
#   value = [for instance in aws_instance.web : instance.public_ip]
# }

# // looping map
# output "ec2_public_ip_map" {
#   value = {
#     for instance in aws_instance.web : instance.id => instance.public_dns
#   }
# }

output "public_info" {
  value = {
    for bz, instance in aws_instance.web : bz => instance.public_ip
  }
}

output "available_az" {
  value = data.aws_ec2_instance_type_offerings.example.locations
}

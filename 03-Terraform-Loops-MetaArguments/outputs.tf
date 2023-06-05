// looping list 
output "ec2_public_ip" {
  value = [for instance in aws_instance.web : instance.public_ip]
}

// looping map
output "ec2_public_ip_map" {
  value = {
    for instance in aws_instance.web : instance.id => instance.public_dns
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "availability_zone" {
  value = data.aws_availability_zones.az.names
}


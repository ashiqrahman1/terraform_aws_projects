output "public_ip" {
  value = [aws_instance.web.public_dns, aws_instance.web.public_ip]
  #   value = aws_instance.web.public_ip
}

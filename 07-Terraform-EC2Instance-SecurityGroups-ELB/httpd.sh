#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable --now httpd
echo "Create By Terraform" > /var/www/html/index.html 
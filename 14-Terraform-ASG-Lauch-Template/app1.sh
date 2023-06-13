#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable --now httpd
yum install mysql -y
mkdir -p /var/www/html/app1/
echo "Create By Terraform $(curl http://169.254.169.254/latest/meta-data/hostname) APP1" > /var/www/html/app1/index.html 
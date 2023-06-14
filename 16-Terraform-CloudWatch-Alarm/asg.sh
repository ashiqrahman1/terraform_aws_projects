#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable --now httpd
yum install mysql -y
echo "Create By Terraform $(curl http://169.254.169.254/latest/meta-data/hostname) ASG" > /var/www/html/index.html 
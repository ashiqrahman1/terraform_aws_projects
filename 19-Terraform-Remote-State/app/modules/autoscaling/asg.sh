#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable --now httpd
yum install mysql -y
echo "Create By Terraform $(hostname) ASG" > /var/www/html/index.html 
#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
systemctl enable --now httpd
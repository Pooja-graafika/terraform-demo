#!/bin/bash

# Create mount volume for logs
  sudo su - root
  mkfs.ext4 /dev/sdf
  mount -t ext4 /dev/sdf /var/log

# Install & Start nginx server
  yum install nginx -y
  systemctl start nginx
  systemctl enable nginx
  
# Print the hostname which includes instance details on nginx homepage  
  sudo echo Hello from `hostname -f` and welcome to my demo and have a nice day!!!... > /usr/share/nginx/html/index.html

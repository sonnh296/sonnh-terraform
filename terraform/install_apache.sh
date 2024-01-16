#!/bin/bash

apt update -y
apt intall httpd -y
systemctl start httpd
systemctl enable httpd

echo "<h1>Hello World from $(hostname -f) </h1>" > /var/www/html/index.html
#!/bin/bash

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
INTERFACE=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
SUBNETID=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${INTERFACE}/subnet-id)
sudo su
echo "<center><h1>This instance is in subnet with ID: $SUBNETID </h1></center>" > /var/www/html/index.html



#!/bin/bash
sudo su
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "<h1>At $(hostname -f) </h1>" > /var/www/html/index.html

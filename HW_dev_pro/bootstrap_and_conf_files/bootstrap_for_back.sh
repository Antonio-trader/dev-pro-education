#!/bin/bash

# install s3fs for nginx
sudo su
yum update -y
amazon-linux-extras install -y epel
yum install -y s3fs-fuse
mkdir /home/ec2-user/s3disk
s3fs -o iam_role=auto -o endpoint=us-west-2 -o url="https://s3-us-west-2.amazonaws.com" bbb-demo-advit /home/ec2-user/s3disk

# install nginx
amazon-linux-extras install -y nginx1
systemctl start nginx.service
systemctl enable nginx.service

# install mariaDB and php
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y  mariadb-server
systemctl start mariadb
systemctl enable mariadb

# add permissions
groupadd www
usermod -a -G www ec2-user
chown -R ec2-user:www /usr/share/nginx/html
chmod 2775 /usr/share/nginx/html && find /usr/share/nginx/html -type d -exec  chmod 2775 {} \;
find /usr/share/nginx/html -type f -exec sudo chmod 0664 {} \;

# install phpmyadmin
yum install php-mbstring php-xml -y
systemctl restart nginx.service
systemctl restart php-fpm
cd /usr/share/nginx/html/
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
mkdir phpMyAdmin && tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1
rm phpMyAdmin-latest-all-languages.tar.gz

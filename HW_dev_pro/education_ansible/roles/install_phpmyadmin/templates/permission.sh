#!/bin/bash

# add permissions
groupadd www
usermod -a -G www ec2-user
chown -R ec2-user:www /usr/share/nginx/html
chmod 2775 /usr/share/nginx/html && find /usr/share/nginx/html -type d -exec  chmod 2775 {} \;
find /usr/share/nginx/html -type f -exec sudo chmod 0664 {} \;
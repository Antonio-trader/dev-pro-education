#!/bin/bash

sudo su
amazon-linux-extras install -y epel
yum install -y s3fs-fuse
mkdir /home/ec2-user/s3disk
s3fs -o iam_role=auto -o endpoint=us-west-2 -o url="https://s3-us-west-2.amazonaws.com" bbb-demo-advit /home/ec2-user/s3disk

amazon-linux-extras install -y nginx1
cp /home/ec2-user/s3disk/nginx.conf /etc/nginx/
systemctl start nginx.service
systemctl enable nginx.service



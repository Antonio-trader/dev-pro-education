#!/bin/bash

ansible-inventory -i /home/local/DO/anton.lukashov/PycharmProjects/dev_pro_education/education/HW_dev_pro/education_ansible/aws_ec2.yml --list > /home/local/DO/anton.lukashov/PycharmProjects/dev_pro_education/education/HW_dev_pro/education_ansible/roles/install_phpmyadmin/templates/test_aws_ec2.json
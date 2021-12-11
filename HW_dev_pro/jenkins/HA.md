![Screenshot](scheme.png)

This schema has information about architecture of project

- There is the cloudflare on the top of schema. It works like an orchestrator between green and blue branch.
- There are two load balancers for green and blue branches after that.
- There are two available zones behind load balancers. Each zone has an instance with Nginx and phpMyAdmin Application. An instance with phpMyAdmin Application connects to database (MariaDB)

How does it work?

i. You should run pipeline_build job in Jenkins. This job has four stages. 
- The first stage is git pull. It downloads all changes from git repo to Jenkins slave
- The second stage is Asible decrypt secret key
- The third stage is run the Terraform script. This stage builds cloud architecture of our project. \
You should choose the one parameter (green or blue) before you start this job. \
When this stage is finished the DNS record with the load balancer will be set to cloudflare. The DNS record depends on your choice. \
If your choice would be green the DNS record included the "green" load balancer, if your choice would be blue the DNS record included the "blue" load balancer. \
All traffic goes through only one load balancer.
- The last stage is deploying (with Ansible) Nginx, Application and Database to instances, which were made by terraform in previous stage.

ii. If you want to change deploy branch from green to blue you should run the Jenkins job with another parameter (for example blue).
The first and second stages go quickly, if you do this. The terraform script changes only DNS record in cloudflare.

iv. What will you do if availability zone is going to break down? \
    You should change available zone in terraform code (variable.tf file), push your changes to Git repo and run Jenkins playbook. \
You should change only available zone only. 

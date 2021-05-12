## Terraform-AWS

On this page:

main.tf - framework for cloud infra being deployed

outputs.tf - gets the resource name of the EC2 once instantiated

variables.tf - variables being called by main.tf
 
### Use Case Description

Spins up an EC2 in Oregon ready for accessing over SSH

### How to test the software

Install Terraform and install AWS creds as you see fit

Create a key in US-West 2 called mykey and install the .pem file in ~/.ssh 

git clone https://github.com/mrdavehill/Terraform--AWS

terraform init

terraform apply

ssh -i ~/.ssh/mykey.pem ec2-user@$(terraform output public_ip)

### Getting help

Hit me up if you have any issues.

### Author

This project was written and is maintained by the following individuals:

* Dave Hill <dave@davehill.org>
* https://www.linkedin.com/in/dave-hill-a5a3601b0/


I'm a network engineer and occasionally I need an EC2 to test connectivity to a resource, run trace-route or just stuff.

This terraform spins up an EC2 in Oregon and is ready for SSH using this command:

ssh -i ~/.ssh/aws_ssh_key.pem ec2-user@$(terraform output public_ip)

You need to create a key in AWS beforehand and install the .pem file in ~/.ssh 

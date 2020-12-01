
# Terraform configuration

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "us-west-2-vpc" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "us-west-2a" {
  vpc_id                  = aws_vpc.us-west-2-vpc.id
  cidr_block              = "10.0.0.0/27"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = "true"

  depends_on              = [aws_internet_gateway.us-west-2-igw]
}


resource "aws_instance" "us-west-2-ec2" {

  subnet_id              = aws_subnet.us-west-2a.id
  ami                    = "ami-0c5204531f799e0c6"
  instance_type          = "t2.micro"

  security_groups = [aws_security_group.ssh.id, aws_security_group.icmp.id]

  key_name               = "aws_ssh_key_aws.eveldave"

  tags = {
    Terraform   = "true"
    Environment = "private"
  }
}

resource "aws_internet_gateway" "us-west-2-igw" {
  vpc_id = aws_vpc.us-west-2-vpc.id
}

resource "aws_route_table" "us-west-2-rt" {
  vpc_id = aws_vpc.us-west-2-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.us-west-2-igw.id
  }
}

resource "aws_route_table_association" "us-west-2a-rta-subnet" {
  subnet_id      = aws_subnet.us-west-2a.id
  route_table_id = aws_route_table.us-west-2-rt.id
}

resource "aws_security_group" "icmp" {
  name                = "allow ICMP"
  vpc_id              = aws_vpc.us-west-2-vpc.id 
  ingress {
      from_port       = 0
      to_port         = 0
      protocol        = "icmp"
      cidr_blocks     = ["0.0.0.0/0"]
    }

  egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }

  lifecycle {
      create_before_destroy = true
    }
}

resource "aws_security_group" "ssh" {
  name                = "allow SSH"
  vpc_id              = aws_vpc.us-west-2-vpc.id
    ingress {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
      from_port      = 0
      to_port        = 0
      protocol       = "-1"
      cidr_blocks    = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
        }
}

output "public_ip" {
  value = aws_instance.us-west-2-ec2.public_ip
}



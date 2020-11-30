
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
  vpc_id            = aws_vpc.us-west-2-vpc.id
  cidr_block        = "10.0.0.0/27"
  availability_zone = "us-west-2a"
}


resource "aws_instance" "us-west-2-ec2" {

  subnet_id              = "aws_subnet.us-west-2a.id"
  ami                    = "ami-0c5204531f799e0c6"
  instance_type          = "t2.micro"

  key_name               = "aws_ssh_key_aws.eveldave"

  tags = {
    Terraform   = "true"
    Environment = "private"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.us-west-2-vpc.id
}



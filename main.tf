# Terraform configuration

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
#select 0 for us-west-2. 1 for eu-west-1 or 2 for eu-west-2
provider "aws" {
  region = var.regions[0]
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = local.common_tags
}

#leave cidr_block untouched
#update availability_zone to match region - 0 for us-west-2. 1 for eu-west-1 or 2 for eu-west-2
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.az_cidr[0]
  availability_zone       = var.azs[var.regions[0]]
  map_public_ip_on_launch = "true"

  depends_on              = [aws_internet_gateway.igw]
}

#update ami to match region - 0 for us-west-2. 1 for eu-west-1 or 2 for eu-west-2
resource "aws_instance" "ec2" {
  subnet_id              = aws_subnet.subnet.id
  ami                    = var.amis[var.regions[0]]
  instance_type          = "t2.micro"

  security_groups = [aws_security_group.ssh.id, aws_security_group.icmp.id]

  key_name               = var.ssh_key

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = local.common_tags
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "icmp" {
  name                = "allow ICMP"
  vpc_id              = aws_vpc.vpc.id
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
  vpc_id              = aws_vpc.vpc.id
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


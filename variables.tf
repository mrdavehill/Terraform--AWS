# Terraform variables

locals {
    common_tags = {
        Terraform   = "true"
        Environment = "private"
    }
}

variable "region" {
    default = "us-west-2"
}

variable "vpc_cidr" {
    default = "10.0.0.0/24"
}

variable "az-a_cidr" {
    default = "10.0.0.0/27"
}

variable "az-a" {
    default = "us-west-2a"
}

variable "ami" {
    default = "ami-0c5204531f799e0c6"
}

variable "ssh_key" {
    default = "aws_ssh_key_aws.eveldave"
}


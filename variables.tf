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

variable "az_cidr" {
    type    = list
    default = ["10.0.0.0/26", "10.0.0.64/26", "10.0.0.128/26", "10.0.0.194/26"]
}

variable "az" {
    type    = list   
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "ami" {
    default = "ami-0c5204531f799e0c6"
}

variable "ssh_key" {
    default = "aws_ssh_key_aws.eveldave"
}


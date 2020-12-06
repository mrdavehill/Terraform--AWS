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

variable "regions" {
    type    = list
    default = ["us-west-2", "eu-west-1", "eu-west-2"]
}

variable "vpc_cidr" {
    default = "10.0.0.0/24"
}

variable "az_cidr" {
    type    = list
    default = ["10.0.0.0/26", "10.0.0.64/26", "10.0.0.128/26", "10.0.0.192/26"]
}

variable "az" {
    type    = list 
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "azs" {
    type    = map
    default = {
        "us-west-2" = "us-west-2a" 
        "us-west-2" = "us-west-2a" 
        "eu-west-1" = "eu-west-1a"
    }
}

variable "ami" {
    default = "ami-01ec00b4d67556905"
}

variable "amis" {
    type    = map
    default = {
        "us-west-2" = "ami-01ec00b4d67556905"
        "eu-west-1" = "ami-09e33dae3dfb2947a"
        "eu-west-2" = "ami-0a76049070d0f8861"
    }
}

variable "ssh_key" {
    default = "aws_ssh_key_aws.eveldave"
}


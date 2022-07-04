terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Web_Server" {
  ami           = "ami-08d4ac5b634553e16"
  instance_type = "t2.micro"
  key_name      = "Key-RicardoCosta"
  vpc_security_group_ids = [
    "sg-05ab2fb5bca4c0c1d",
    "sg-01c755d675702f501",
    "sg-0677f61f65d157377"
  ]
  tags = {
    Name = "Web_Server_Ubu_01"
  }
}
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
  region = var.regiao_aws
}

resource "aws_instance" "Web_Server" {
  ami           = "ami-08d4ac5b634553e16"
  instance_type = var.instancia
  key_name      = var.chave
  vpc_security_group_ids = [
    "sg-05ab2fb5bca4c0c1d",
    "sg-01c755d675702f501",
    "sg-0677f61f65d157377",
    "sg-08812bf19eddffd8c"
  ]
  tags = {
    Name = var.nome_instancia
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name   = var.chave
  public_key = file("${var.chave}.pub")

}
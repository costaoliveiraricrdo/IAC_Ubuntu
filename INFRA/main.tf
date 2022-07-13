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
#  key_name      = var.chave
#  vpc_security_group_ids = [
#    "sg-05ab2fb5bca4c0c1d",
#    "sg-01c755d675702f501",
#    "sg-0677f61f65d157377",
#    "sg-08812bf19eddffd8c"
#  ]

  tags = {
    Name = var.nome_instancia
  }
}

module "vpc" {
  source  = "../INFRA"

  name = "aws-cloud-${var.infra_env}-vpc"
  cidr = var.vpc_cidr

  azs = var.azs

  # Single NAT Gateway
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  tags = {
    Name = "aws-cloud-${var.infra_env}-vpc"
    Project = "Ubuntu Django Web Server"
    Environment = var.infra_env
    ManagedBy = "terraform"
  }
}
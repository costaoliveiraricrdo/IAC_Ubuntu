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

resource "aws_instance" "web_server" {
  ami                    = "ami-08d4ac5b634553e16"
  instance_type          = var.instancia
  key_name               = var.chave
  vpc_security_group_ids = [
    var.grupo_seguranca
  ]

  tags = {
    Name = var.nome_instancia
  }

  provisioner "remote-exec" {
    inline  = ["echo 'Wait until SSH is ready...'"]

    connection {
      type        = "ssh"
      user        = var.nome_usuario
      private_key = file(var.chave)
      host        = aws_instance.web_server.public_ip
    }
  }

  provisioner "local-exec" {
    command       = "ansible-playbook ../DEV/playbook.yml -i ${aws_instance.web_server.public_ip} --private-key ${var.chave}"
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name   = var.chave
  public_key = file("${var.chave}.pub")

}

output "IP_publico" {
  value = aws_instance.web_server.public_ip
}

output "security_group_public" {
  value = aws_security_group.public.id
}
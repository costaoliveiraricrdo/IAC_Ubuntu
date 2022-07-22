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
  ami           = "ami-08d4ac5b634553e16"
  instance_type = var.instancia
  key_name      = var.chave
  vpc_security_group_ids = [
    var.grupo_seguranca
  ]

  tags = {
    Name = var.nome_instancia
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name   = var.chave
  public_key = file("${var.chave}.pub")

}

resource "local_file" "ip" {
  content   = aws_instance.web_server.public_ip
  filename  = "ip.txt" 
}

resource "null_resource" "nullremote1" {
  #depends_on = [aws_instance.web_server]
    
  connection {
      type        = "ssh"
      user        = var.nome_usuario
      private_key = file(var.chave)
      host        = aws_instance.web_server.public_ip
    }
  provisioner "file" {
    source = "ip.txt"
    destination = "../DEV/ip.txt"
  }  
}

resource "null_resource" "nullremote2" {
  depends_on = [aws_instance.web_server]
    
    provisioner "local-exec" {
    command = "aws --profile default ec2 wait instance-status-ok --region us-east-1 --instance-ids ${self.id} && ansible-playbook ${var.ansible_path} -i ${aws_instance.web_server.public_ip} --private-key ${var.chave}"
  
    connection {
      type        = "ssh"
      user        = var.nome_usuario
      private_key = file(var.chave)
      host        = aws_instance.web_server.public_ip
    }
  }
}

output "IP_publico" {
  value = aws_instance.web_server.public_ip
}

output "security_group_public" {
  value = aws_security_group.public.id
}
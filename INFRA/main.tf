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
  region = "${var.regiao_aws}"
}

resource "aws_key_pair" "chaveSSH" {
  key_name   = "${var.chave}"
  public_key = file("${var.chave}.pub")
}

resource "aws_instance" "web_server" {
  ami           = "${var.ami}"
  instance_type = "${var.instancia}"
  key_name      = "${var.chave}"
  vpc_security_group_ids = [
    "${var.grupo_seguranca}"
  ]

  tags = {
    Name = "${var.nome_instancia}"
  }
}

resource "local_file" "ip" {
  connection {
    type        = "ssh"
    user        = "${var.nome_usuario}"
    private_key = file("${var.chave}")
    host        = aws_instance.web_server.public_ip
  }
  
  content   = aws_instance.web_server.public_ip
  filename  = "ip.txt" 
}

resource "null_resource" "nullremote1" {
  depends_on = [aws_instance.web_server]
    
  connection {
      type        = "ssh"
      user        = "${var.nome_usuario}"
      private_key = file("${var.chave}")
      host        = aws_instance.web_server.public_ip
    }
  provisioner "file" {
    source = "ip.txt"
    destination = "../DEV/ip.txt"
  }  
}

resource "null_resource" "nullremote2" {
  depends_on = [aws_instance.web_server]
    
  connection {
    type        = "ssh"
    user        = "${var.nome_usuario}"
    private_key = file("${var.chave}")
    host        = aws_instance.web_server.public_ip
  } 

  provisioner "remote-exec" {
    command = "aws --profile default ec2 wait instance-status-ok --region us-east-1 --instance-ids ${self.id} && ansible-playbook ${var.ansible_path} -i ${aws_instance.web_server.public_ip} --private-key ${var.chave}"
  }
}

output "IP_publico" {
  value = aws_instance.web_server.public_ip
}

output "security_group_public" {
  value = aws_security_group.public.id
}
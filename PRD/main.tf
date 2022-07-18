module "aws-prd" {
  source          = "../INFRA"
  instancia       = "t2.micro"
  regiao_aws      = "us-east-1"
  chave           = "IaC-PRD"
  nome_instancia  = "PRD_Web_Server_01"
  infra_env       = "production-environment"
  grupo_seguranca = module.aws-prd.security_group_public
}

output "IP" {
  value = module.aws-prd.IP_publico
}

output "SG_public" {
  value = module.aws-prd.security_group_public
}

provisioner "remote-exec" {
  inline  = ["echo 'Wait until SSH is ready...'"]

  connection {
    type        = "ssh"
    user        = var.nome_usuario
    private.key = file(var.chave)
    host        = aws_instance.web_server.public_ip
  }
}

provisioner "local-exec" {
  command       = "ansible-playbook playbook.yml -i ${aws_instance.web_server.public_ip} --private-key ${var.chave}"
}
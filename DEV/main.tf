module "aws-dev" {
  source          = "../INFRA"
  instancia       = "t2.micro"
  regiao_aws      = "us-east-1"
  chave           = "IaC-DEV"
  nome_instancia  = "DEV_Web_Server_01"
  infra_env       = "development-environment"
  nome_usuario    = "ubuntu"
  grupo_seguranca = module.aws-dev.security_group_public
}

output "IP" {
  value = module.aws-dev.IP_publico
}

output "SG_public" {
  value = module.aws-dev.security_group_public
}


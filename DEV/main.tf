module "aws-dev" {
  source          = "../INFRA"
  ami             = "ami-08d4ac5b634553e16"
  instancia       = "t2.micro"
  regiao_aws      = "us-east-1"
  chave           = "IaC-DEV"
  nome_instancia  = "DEV_Web_Server_10"
  infra_env       = "development-environment"
  nome_usuario    = "ubuntu"
  ansible_path    = "../DEV/playbook.yml"
  grupo_seguranca = module.aws-dev.security_group_public
}

output "IP" {
  value = module.aws-dev.IP_publico
}

output "SG_public" {
  value = module.aws-dev.security_group_public
}
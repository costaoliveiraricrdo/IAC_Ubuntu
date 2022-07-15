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

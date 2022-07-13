module "aws-prd" {
  source         = "../INFRA"
  instancia      = "t2.micro"
  regiao_aws     = "us-east-1"
  chave          = "IaC-PRD"
  nome_instancia = "PRD_Web_Server_01"
  infra_env      = "Production-Environment"
  subnets        = module.vpc.vpc_public_subnets
  security_groups = [module.vpc.security_group_public]
  tags = {
    Name = "aws-cloud-${var.infra_env}-web"
  }
  create_eip = true
}
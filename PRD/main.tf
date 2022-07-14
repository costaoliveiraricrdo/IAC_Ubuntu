module "aws-prd" {
  source         = "../INFRA"
  instancia      = "t2.micro"
  regiao_aws     = "us-east-1"
  chave          = "IaC-PRD"
  nome_instancia = "PRD_Web_Server_01"
}


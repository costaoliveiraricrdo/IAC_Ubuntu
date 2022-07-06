module "aws-dev" {
  source         = "../INFRA"
  instancia      = "t2.micro"
  regiao_aws     = "us-east-1"
  chave          = "IaC-DEV"
  nome_instancia = "DEV_Web_Server_01"
}


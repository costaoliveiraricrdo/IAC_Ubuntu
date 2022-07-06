module "aws-prd" {
    source = "../INFRA"
    instancia = "t2.small"
    regiao_aws = "us-east-1"
    chave = "IaC-PRD"
    nome_host = "PRD_Web_Server_01"
}


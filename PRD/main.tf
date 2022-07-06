module "aws-prd" {
    source = "../INFRA"
    instancia = "t2.small"
    regiao_aws = "us-east-2"
    chave = "IaC-PRD"
    nome_instancia = "PRD_Web_Server_01"
}


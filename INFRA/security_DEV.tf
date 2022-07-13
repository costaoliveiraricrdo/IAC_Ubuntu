################################################
# Politicas Gerais de Segurança Ambiente DEV
################################################

################################################
# Chaves SSH  
#
resource "aws_key_pair" "chave_SSH" {
  key_name   = var.chave
  public_key = file("${var.chave}.pub")
}

###############################################
# Public Security Group
#
resource "aws_security_group" "public" {
  name = "aws-cloud-${var.infra_env}-public-sg"
  description = "Public Internet Access"
  vpc_id = module.vpc.vpc_id 

  tags = {
    Name        = "aws-cloud-${var.infra_env}-public-sg"
    Role        = "public"
    Project     = "Ubuntu Django Web Server Developmento and Production Environment.io"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_http_https" {
  type              = "ingress"
  from_port         = [80, 8080, 443]
  to_port           = [80, 8080, 443]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_Django_Web_Server" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_ICMP" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

###############################################
# Private Security Group
#
resource "aws_security_group" "private" {
  name = "aws-cloud-${var.infra_env}-private-sg"
  description = "Private Internet Access"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name        = "aws-cloud-${var.infra_env}-private-sg"
    Role        = "private"
    Project     = "Ubuntu Django Web Server DEV Environment.io"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_security_group_rule" "private_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  
  security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "private_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks = [module.vpc.vpc_cidr_block]

  security_group_id = aws_security_group.private.id
}

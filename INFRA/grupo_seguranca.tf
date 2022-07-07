resource "aws_security_group" "aws_grupos_de_segurança" {
  name = "acesso_web"
  description = "Grupo de Segurança acesso WEB ambiente DEV"
  ingress{
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port = 80
    to_port = 80
    protocol = "http"
    
  }

  egress{

  }

  tags = {
    name = "Acesso Web"
  }
}
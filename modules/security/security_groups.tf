resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = var.cidr_from_anywhere_ipv4
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv6" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv6         = var.cidr_from_anywhere_ipv6
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

output "allow_http_sg_id" {
    value = aws_security_group.allow_http.id
}



resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_from_anywhere_ipv4
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = var.cidr_from_anywhere_ipv6
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# TODO: move this to default group !?!
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

output "allow_tls_sg_id" {
    value = aws_security_group.allow_tls.id
}





resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = var.cidr_from_anywhere_ipv4
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv6         = var.cidr_from_anywhere_ipv6
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

variable "vpc_id" {}

variable "cidr_from_anywhere_ipv4" {}

variable "cidr_from_anywhere_ipv6" {}

output "allow_ssh_sg_id" {
    value = aws_security_group.allow_ssh.id
}






variable "vpc_cidr" {}

# For NAT instance 
resource "aws_security_group" "allow_http_nat" {
  name        = "allow_http_nat"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http_nat"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_nat" {
  security_group_id = aws_security_group.allow_http.id
  #cidr_ipv4         = var.cidr_from_anywhere_ipv4
  cidr_ipv4         = var.vpc_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Still not sure how to handle ipv6 address space 
# resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv6_nat" {
#   security_group_id = aws_security_group.allow_http.id
#   cidr_ipv6         = var.cidr_from_anywhere_ipv6
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

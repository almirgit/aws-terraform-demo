variable project_name {
  type = string
}
variable "vpc_id" {
  type = string
}
variable internet_gateway {
  #type = string
}
variable "nat_gateway" {
  #type = string  
}
variable "public_subnet_az1_id" {
  type = string  
}
variable "public_subnet_az2_id" {
  type = string  
}
variable "private_app_subnet_az1_id" {
  type = string    
}
variable "private_app_subnet_az2_id" {
  type = string    
}



# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway.id
  }

  tags       = {
    Name     = "Public route table"
    Project = var.project_name
  }
}

# create route table and add private route
resource "aws_route_table" "private_route_table" {
  vpc_id       = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_gateway.id
    #gateway_id = aws_instance.nat.id # NAT instance
  }

  tags       = {
    Name     = "Private route table"
    Project = var.project_name
  }
}



# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = var.public_subnet_az1_id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = var.public_subnet_az2_id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate private subnet to private route table 1
resource "aws_route_table_association" "private_subnet_az1_route_table_association" {
  subnet_id           = var.private_app_subnet_az1_id
  route_table_id      = aws_route_table.private_route_table.id
}

# associate private subnet to private route table 2
resource "aws_route_table_association" "private_subnet_az2_route_table_association" {
  subnet_id           = var.private_app_subnet_az2_id
  route_table_id      = aws_route_table.private_route_table.id
}

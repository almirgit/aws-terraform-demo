# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "Public route table"
  }
}

# create route table and add private route
resource "aws_route_table" "private_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #gateway_id = aws_nat_gateway.nat.id
    gateway_id = aws_instance.nat.id # NAT instance
  }

  tags       = {
    Name     = "Private route table"
  }
}



# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate private subnet to private route table 1
resource "aws_route_table_association" "private_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.private_app_subnet_az1.id
  route_table_id      = aws_route_table.private_route_table.id
}

# associate private subnet to private route table 2
resource "aws_route_table_association" "private_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.private_app_subnet_az2.id
  route_table_id      = aws_route_table.private_route_table.id
}

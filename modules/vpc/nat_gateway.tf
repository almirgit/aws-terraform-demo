# Do I need this?
# resource aws_eip "nat_eip" {

# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public_subnet_az1.id

#   tags = {
#     Name = "NAT Gateway"
#   }

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.internet_gateway]
# }


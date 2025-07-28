# variable "key_pair" {}
# variable "project_name" {}
# variable "subnet_id" {
#     description = "The ID of the subnet where the NAT instance will be launched."
#     type        = string
#  }
#  variable vpc_security_group_ids {
#     description = "List of security group IDs to associate with the NAT instance."
#     type        = list(string)
#  }


# # Do I need this?
# # resource aws_eip "nat_eip" {

# # }

# # non-managed solution, to save some money while testing: NAT instance
# # https://medium.com/@luquinte/create-a-nat-instance-using-terraform-d107c47c9202

# # Get test instance Image Id for Amazon Linux 2023
# data "aws_ami" "amzn-linux-2023-ami" {
#   most_recent = true
#   owners      = ["amazon"]
#   filter {
#     name   = "name"
#     #values = ["al2023-ami-2023.*-x86_64"]
#     values = ["nats-2024-12-17 05_17_38-c4e12882-bacb-47db-9d55-19e6e5df3a41"]
#   }
# }

# │ Error: Your query returned no results. Please change your search criteria and try again.
# │ 
# │   with module.nat_instance.data.aws_ami.amzn-linux-2023-ami,
# │   on ../modules/nat_instance/nat_instance.tf line 22, in data "aws_ami" "amzn-linux-2023-ami":
# │   22: data "aws_ami" "amzn-linux-2023-ami" {
# │ 
# ╵


# # Build the test instance
# resource "aws_instance" "nat" {
#   #ami                    = data.aws_ami.amzn-linux-2023-ami.id # Free-tier
#   ami                    = "ami-0ef1d80bdc9dc7324"
#   instance_type          = "t2.micro"
#   #public_ip              = aws_eip.nat_eip.id
#   subnet_id              =  var.subnet_id 
#   vpc_security_group_ids = var.vpc_security_group_ids
#   key_name               = var.key_pair

#   # Root disk for test instance
#   root_block_device {
#     volume_size = "8"
#     volume_type = "gp2"
#     encrypted   = true
#   }
#   tags = {
#     Name = "nat-instance1"
#     Project = var.project_name
#   }
# }

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ec2_ubuntu_box" {
  count                  = var.box_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups

  key_name        = "almir-id-rsa"

  tags = {
    Name = var.name
  }

  user_data = var.user_data
}

variable "box_count" {
  type = number
  default = 1
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = string
  default = ""
}

variable "security_groups" {
  type = list(string)
  default = [ "" ]
}

variable "name" {
  type = string
  default = ""
}

variable "user_data" {
  type = string
  default = ""
}

output "ec2_ubuntu_box_instances" {
  value = aws_instance.ec2_ubuntu_box
}

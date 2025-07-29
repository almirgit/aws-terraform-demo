# Configure AWS provider
provider "aws" {
    region  = var.region
    profile = var.aws_profile
}

# Create S3 bucket for logs
module "s3_log" {
   source = "../modules/s3"
   principal_identifier = var.principal_identifier
   project_name = var.project_name
   #trusted_role_arn = module.alb1.alb_arn
}

# Route 53
module "route53" {
   source        = "../modules/route53"
   test_site_url = var.test_site_url
}

# Create VPC
module "vpc1" {
   source                          = "../modules/vpc"
   region                          = var.region
   project_name                    = var.project_name
   vpc_cidr                        = var.vpc_cidr   
   public_subnet_az1_cidr          = var.public_subnet_az1_cidr
   public_subnet_az2_cidr          = var.public_subnet_az2_cidr
   private_app_subnet_az1_cidr     = var.private_app_subnet_az1_cidr
   private_app_subnet_az2_cidr     = var.private_app_subnet_az2_cidr
   private_data_subnet_az1_cidr    = var.private_data_subnet_az1_cidr
   private_data_subnet_az2_cidr    = var.private_data_subnet_az2_cidr
}

# Security
module "security" {
   source = "../modules/security"
   project_name = var.project_name
   vpc_id = module.vpc1.vpc_id
   vpc_cidr = var.vpc_cidr
   cidr_from_anywhere_ipv4 = "0.0.0.0/0"
   cidr_from_anywhere_ipv6 = "::/0"
}

# # Create NAT instance - Looks like it's not free anymore (2025)
# module "nat_instance" {
#    source                          = "../modules/nat_instance"
#    project_name                    = var.project_name
#    key_pair                        = var.key_pair
#    subnet_id                       = module.vpc1.public_subnet_az1_id
#    vpc_security_group_ids          = [module.security.allow_ssh_sg_id, 
#                                       module.security.allow_http_https_sg_id]
# }

# # # Create routes
# module "routes" {
#    source                          = "../modules/routes"
#    project_name                    = var.project_name
#    vpc_id                          = module.vpc1.vpc_id
#    internet_gateway                = module.vpc1.internet_gateway
#    nat_gateway                     = module.vpc1.nat_gateway
#    public_subnet_az1_id            = module.vpc1.public_subnet_az1_id
#    public_subnet_az2_id            = module.vpc1.public_subnet_az2_id
#    private_app_subnet_az1_id       = module.vpc1.private_app_subnet_az1_id
#    private_app_subnet_az2_id       = module.vpc1.private_app_subnet_az2_id
# }


#module "ec2_bastion" {
#    source          = "../modules/ec2"
#    subnet_id       = module.vpc1.public_subnet_az1_id
#    security_groups = [module.security.allow_ssh_sg_id] 
#    name            = "Bastion"
#}
#
#module "ec2_workers" {    
#    source          = "../modules/ec2"
#    box_count       = 2
#    subnet_id       = module.vpc1.private_app_subnet_az1_id
#    security_groups = [module.security.allow_ssh_sg_id, module.security.allow_http_sg_id] 
#    name            = "App Worker"
#    user_data = <<EOF
##!/bin/bash -x
##echo "script start" > /home/ubuntu/debug.txt
#sudo apt update
#sudo apt install -y nginx
#sudo systemctl start nginx
#sudo systemctl enable nginx
#hostname=`cat /etc/hostname` && echo "<html><head></head><body><p>$hostname</p></body></html>" | sudo tee /var/www/html/index.html
#EOF
#}
#
#module "alb1" {
#    source                 = "../modules/lb"
#    alb_name               = "alb1"
#    subnet_ids             = [module.vpc1.public_subnet_az1_id, module.vpc1.public_subnet_az2_id]
#    alb_security_group_ids = [module.security.allow_tls_sg_id, module.security.allow_http_sg_id]
#    s3_log_id              = module.s3_log.kodera_alb_log_id
#    vpc_id                 = module.vpc1.vpc_id
#    worker_ec2_instances   = module.ec2_workers.ec2_ubuntu_box_instances
#    test_site_url          = var.test_site_url
#    certificate_arn        = var.certificate_arn
#    route53_zone_id        = module.route53.koderacloud_net_zone_id
#}


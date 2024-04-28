# Get hosted zone
data "aws_route53_zone" "hosted_zone" {
    name = var.domain_name
}

# Create record set
resource "aws_route53_record" "default" {
    zone_id = data.aws_route53_zone.hosted_zone.zone_id
    name    = ""
    type    = "A"
    ttl     = 300
    records = ["116.203.233.203"]  
}

# resource "aws_route53_record" "test" {
#     zone_id = data.aws_route53_zone.hosted_zone.zone_id
#     name    = "test.koderacloud.net"
#     type    = "CNAME"
#     ttl     = 300
#     records = ["koderacloud.net"]  
# }

variable "domain_name" {
    default     = "koderacloud.net"
    description = "Domain name"
    type        = string  
}

variable "record_name" {
    default     = "www"
    description = "Subdomain name"
    type        = string  
}

variable "test_site_url" {
    #default = "test.${var.domain_name}"
    default = "test.koderacloud.net"
    description = "Test site"
    type = string  
}

output "koderacloud_net_zone_id" {
    value = data.aws_route53_zone.hosted_zone.zone_id
}


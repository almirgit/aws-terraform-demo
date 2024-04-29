resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  security_groups    = var.alb_security_group_ids
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets            = var.subnet_ids
  enable_deletion_protection = false

  access_logs {
    #bucket  = aws_s3_bucket.lb_logs.id
    bucket  = var.s3_log_id
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "demo_alb_tg" {
  name     = "demo-tg-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "demo_alb_tg_attachment" {
  # covert a list of instance objects to a map with instance ID as the key, and an instance
  # object as the value.
  for_each = {
    for k, v in var.worker_ec2_instances:
    k => v
  }

  target_group_arn = aws_lb_target_group.demo_alb_tg.arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  #port              = "80"
  #protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_alb_tg.arn
  }
}


resource "aws_route53_record" "www" {
  zone_id = var.route53_zone_id
  name    = var.test_site_url
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

variable "vpc_id" {}

variable "subnet_ids" {}

variable "alb_security_group_ids" {}

variable "s3_log_id" {}

variable "alb_name" {}

variable "worker_ec2_instances" {}

variable "certificate_arn" {
    type = string
    default = ""
}

variable "route53_zone_id" {
    type = string
}

variable "test_site_url" {
  type = string
}

output "alb_arn" {
    value = aws_lb.alb.arn
} 
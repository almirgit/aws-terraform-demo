variable "project_name" {
  type = string
}

variable "principal_identifier" {
    type = string
}

#variable "trusted_role_arn" {
#    type = string
#}


resource "aws_s3_bucket" "alb_log" {
  bucket = "kodera-alb-log"

  tags = {
    #Name        = "My bucket"
    #Environment = "dev"
    Project = var.project_name
  }
}

data "aws_elb_service_account" "main" {}

data "aws_iam_policy_document" "allow_access_from_alb" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.main.arn] # Needs to be per region predefined AWS account
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      #aws_s3_bucket.alb_log.arn,
      "${aws_s3_bucket.alb_log.arn}/*",
    ]
  }
}


resource "aws_s3_bucket_policy" "allow_access_from_alb" {
  bucket = aws_s3_bucket.alb_log.bucket
  policy = data.aws_iam_policy_document.allow_access_from_alb.json
}


output "kodera_alb_log_id" {
    value = aws_s3_bucket.alb_log.id
}

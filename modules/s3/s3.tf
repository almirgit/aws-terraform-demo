resource "aws_s3_bucket" "alb_log" {
  bucket = "kodera-alb-log"

  tags = {
    #Name        = "My bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_alb" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.allow_access_from_alb.json
}

data "aws_iam_policy_document" "allow_access_from_alb" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::054676820928:root"]
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

output "kodera_alb_log_id" {
    value = aws_s3_bucket.alb_log.id
}

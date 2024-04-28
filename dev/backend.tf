terraform {
  backend "s3" {
    bucket  = "kodera-aws-tfstate"
    key     = "eu-central-1/terraform.tfstate"
    region  = "eu-central-1"
    profile = "default"
  }
}
# AWS Load Balancer Demo

## Install

```
git clone git@github.com:almirgit/aws-terraform-demo.git
```

## Config

Config parameters are inside of ***terraform.tfvars*** except parameter "certificate_arn" which can be stored in *** .secret.auto.tfvars ***

## Run

```
cd dev
```

```
terraform init
terraform plan -out=plan.out
terraform apply "plan.out"
```

## Test

Visit https://test.*yourdomain.net*


provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "aws-fargate-demo-bucket/terraform/main.tf"
  }
}

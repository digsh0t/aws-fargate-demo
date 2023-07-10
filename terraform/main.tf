provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Stack       = var.name
      Environment = var.environment
    }
  }
}

terraform {
  backend "s3" {
    key = "aws-fargate-demo-bucket/terraform/main.tf"
  }
}

# module "vpc" {
#   source             = "./modules/global/vpc"
#   cidr               = var.cidr
#   availability_zones = var.availability_zones
#   private_subnets    = var.private_subnets
#   public_subnets     = var.public_subnets
# }

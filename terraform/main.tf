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

module "vpc" {
  source             = "./modules/global/vpc"
  cidr               = var.cidr
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
}

module "amazon-rds" {
  source      = "./modules/services/amazon-rds"
  db_name     = "demo-db"
  db_username = "postgres"
  db_password = "Sandworm1$"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
}

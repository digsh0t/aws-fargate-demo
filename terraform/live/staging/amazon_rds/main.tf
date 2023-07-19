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
    key = "live/staging/amazon_rds/main.tfstate"
  }
}

data "aws_vpc" "demo_vpc" {
  backend = "s3"

  config = {
    bucket = "aws-fargate-demo-bucket"
    key    = "live/staging/vpc/terraform.tfstate"
    region = "us-east-2"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpc.demo_vpc.id
  }

  tags = {
    Tier = "Private"
  }
}

module "amazon-rds" {
  source      = "./modules/services/amazon-rds"
  db_name     = "demo-db"
  db_username = "postgres"
  db_password = "Sandworm1$"
  vpc_id      = data.aws_vpc.demo_vpc.id
  subnet_ids  = data.aws_subnets.private.ids
}

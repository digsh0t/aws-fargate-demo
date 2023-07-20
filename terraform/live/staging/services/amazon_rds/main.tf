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
    key = "live/staging/services/amazon_rds/main.tfstate"
  }
}

data "terraform_remote_state" "demo_vpc" {
  backend = "s3"

  config = {
    bucket = "aws-fargate-demo-bucket"
    key    = "live/staging/global/vpc/main.tfstate"
    region = "us-east-2"
  }
}

module "amazon-rds" {
  source      = "../../../../modules/services/amazon-rds"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  vpc_id      = data.terraform_remote_state.demo_vpc.outputs.vpc_id
  subnet_ids  = data.terraform_remote_state.demo_vpc.outputs.private_subnet_ids
}

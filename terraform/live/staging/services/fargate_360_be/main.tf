terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    key = "aws-fargate-demo/terraform/live/staging/services/fargate_360_be/main.tfstate"
  }
}

provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Stack       = var.name
      Environment = var.environment
    }
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

module "elb" {
  source = "../../../../modules/services/elb"

  vpc_id     = data.terraform_remote_state.demo_vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.demo_vpc.outputs.public_subnet_ids
}

module "ecs" {
  source = "../../../../modules/services/ecs-fargate"

  aws_alb_target_group_arn = module.elb.aws_alb_target_group_arn
  container_environment = {
    SERVER_NAME = var.uvicorn_server_name
  }
  container_name = var.container_name
  container_port = var.container_port
  image_path     = var.image_path
  vpc_id         = data.terraform_remote_state.demo_vpc.outputs.vpc_id
  subnet_ids     = data.terraform_remote_state.demo_vpc.outputs.public_subnet_ids
  region         = var.region
}

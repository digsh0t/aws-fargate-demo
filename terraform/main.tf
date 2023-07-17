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

# module "amazon-rds" {
#   source      = "./modules/services/amazon-rds"
#   db_name     = "demo-db"
#   db_username = "postgres"
#   db_password = "Sandworm1$"
#   vpc_id      = module.vpc.vpc_id
#   subnet_ids  = module.vpc.private_subnet_ids
# }

# data "archive_file" "lambdazip" {
#   type        = "zip"
#   output_path = "${path.module}/artifacts/slack_lambda.zip"

#   source_dir = "${path.module}/artifacts/lambda/"
# }

# module "slack_lambda" {
#   source = "./modules/services/lambda"

#   name          = "slack_lambda"
#   description   = "notify slack channel on sns topic"
#   artifact_file = "${path.module}/artifacts/slack_lambda.zip"
#   handler       = "slack_lambda.lambda_handler"
#   runtime       = "python3.8"
#   memory_size   = 128
#   timeout       = 30
#   environment = {
#     "SLACK_URL"     = var.slack_url
#     "SLACK_CHANNEL" = var.slack_channel
#     "SLACK_USER"    = var.slack_user
#   }

#   tags = {
#     Queue = "demo_queue"
#   }
# }

# module "sns_topic" {
#   source = "./modules/services/sns"

#   slack_lambda_arn = module.slack_lambda.arn
# }

# module "cloudwatch-alert" {
#   source        = "./modules/services/cloudwatch-alert"
#   alert_name    = "demo_alert"
#   sns_topic_arn = module.sns_topic.sns_topic_arn
# }

module "elb" {
  source = "./modules/services/elb"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
}

module "ecs" {
  source = "./modules/services/ecs-fargate"

  aws_alb_target_group_arn = module.elb.aws_alb_target_group_arn
  container_environment = {
    SERVER_NAME = var.uvicorn_server_name
    DB_HOST     = var.db_host
    DB_PORT     = var.db_port
    DB_NAME     = var.db_name
    DB_USERNAME = var.db_username
    DB_PASSWORD = var.db_password
  }
  container_name = "demo_uvicorn_app"
  container_port = 8080
  image_path     = "public.ecr.aws/a3b1j4l7/aws-fargate-demo-registry@sha256:c781859dd517e5623a9f7dbe0159a2890bdadb71f53d016679951d4bd8e98596"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  region         = "us-east-2"
}

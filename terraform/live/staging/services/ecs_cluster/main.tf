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
    key = "aws-fargate-demo-bucket/terraform/main.tfstate"
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

data "terraform_remote_state" "demo_db" {
  backend = "s3"

  config = {
    bucket = "aws-fargate-demo-bucket"
    key    = "live/staging/services/amazon_rds/main.tfstate"
    region = "us-east-2"
  }
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

  vpc_id     = data.terraform_remote_state.demo_vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.demo_vpc.outputs.public_subnet_ids
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
  container_name = var.container_name
  container_port = var.container_port
  image_path     = var.image_path
  vpc_id         = data.terraform_remote_state.demo_vpc.outputs.vpc_id
  subnet_ids     = data.terraform_remote_state.demo_vpc.outputs.public_subnet_ids
  region         = var.region
}

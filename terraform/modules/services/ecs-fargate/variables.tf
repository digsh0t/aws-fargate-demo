variable "container_name" {
  description = "Name of the ECS service container"
  type        = string
}

variable "image_path" {
  description = "Path to the Image including tag"
  type        = string
}

variable "container_environment" {
  description = "Environments of container"
  type        = map(string)
}

variable "container_port" {
  description = "Port of the container"
  type        = number
}

variable "vpc_id" {
  description = "The id of VPC used for ECS"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet ids to be used for ECS"
  type        = list(string)
}

variable "aws_alb_target_group_arn" {
  description = "The subnets to be used for ECS"
  type        = string
}

variable "region" {
  description = "Region to used in Cloudwatch Log Groups"
  type        = string
}

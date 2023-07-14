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
}

variable "vpc_id" {
  description = "The id of VPC used for ECS"
}

variable "name" {
  description = "the name of your stack, e.g. \"aws-fargate-demo\""
  default     = "aws-fargate-demo"
}

variable "environment" {
  description = "the name of your environment, e.g. \"demo\""
  default     = "demo"
}

variable "region" {
  description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
  default     = "us-east-2"
}

variable "uvicorn_server_name" {
  description = "Name of The Python Uvicorn server"
  type        = string
  default     = "DigSh0t's demo website"
}

variable "container_name" {
  description = "Name of The Container in ECS task"
  type        = string
  default     = "demo_uvicorn"
}

variable "container_port" {
  description = "Port number used in the Container in ECS task"
  type        = number
  default     = 8080
}

variable "image_path" {
  description = "URL to image"
  type        = string
}

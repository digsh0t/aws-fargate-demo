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

variable "slack_url" {
  description = "slack hook url, eg. https://hooks.slack.com/services/xxxxxxxxxxxxx"
  type        = string
  default     = ""
}
variable "slack_channel" {
  description = "slack channel, eg. #mychannel"
  type        = string
  default     = ""
}
variable "slack_user" {
  description = "slack user"
  type        = string
  default     = ""
}

variable "uvicorn_server_name" {
  description = "Name of The Python Uvicorn server"
  type        = string
  default     = "DigSh0t's demo website"
}

variable "db_host" {
  description = "The Host IP of DB"
  type        = string
}

variable "db_port" {
  description = "The Host Port of DB"
  type        = string
}

variable "db_name" {
  description = "The name of DB"
  type        = string
}

variable "db_username" {
  description = "The username of DB"
  type        = string
}

variable "db_password" {
  description = "The password of DB"
  type        = string
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
  type        = sring
}

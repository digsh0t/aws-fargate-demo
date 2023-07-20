variable "name" {
  description = "the name of your stack, e.g. \"aws-fargate-demo\""
  default     = "aws-fargate-demo"
}

variable "environment" {
  description = "the name of your environment, e.g. \"demo\""
  default     = "demo"
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

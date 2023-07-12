variable "db_username" {
  description = "The username for the DB master user"
  type        = string
  sensitive   = true
}
variable "db_password" {
  description = "The password for the DB master user"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the DB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}


variable "subnet_ids" {
  description = "List of subnet ids for DB"
  type        = list(string)
}

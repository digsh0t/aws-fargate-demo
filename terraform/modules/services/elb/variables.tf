variable "vpc_id" {
  description = "The Id of VPC used for the ELB"
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet ids to be used by ELB"
  type        = list(string)
}

variable "health_check_path" {
  description = "The path for health check"
  type        = string
  default     = "/"
}


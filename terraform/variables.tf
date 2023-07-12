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

variable "aws-region" {
  type        = string
  description = "AWS region to launch servers."
  default     = "us-east-2"
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.128.0/20", "10.0.144.0/20"]
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

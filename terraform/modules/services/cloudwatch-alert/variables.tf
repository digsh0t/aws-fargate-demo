variable "alert_name" {
  description = "Alert for RabbitMQ's total messages in a queue"
}

variable "sns_topic_arn" {
  description = "ARN of SNS Topic that will receive notification from Cloudwatch Metrics"
}

variable "dimensions" {
  type        = map(string)
  description = "The Cloudwatch metric dimensions"
  default     = {}
}

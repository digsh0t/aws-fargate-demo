resource "aws_cloudwatch_metric_alarm" "demo-alert" {
  alarm_name          = var.alert_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "Messages"

  namespace                 = "RabbitMQ"
  period                    = 60
  statistic                 = "Sum"
  threshold                 = 3
  alarm_description         = "This metric monitors total number of messages in queue demo_queue"
  alarm_actions             = [var.sns_topic_arn]
  insufficient_data_actions = []
  dimensions = {
    Queue   = "demo_queue"
    Metric  = "Queue"
    VHost   = "/"
    Cluster = "rabbit@ip-172-31-4-62.us-east-2.compute.internal"
  }
  #   dynamic "dimensions" {
  #     for_each = (length(var.dimensions) > 0 ? [1] : [])
  #     content {
  #       variables = var.dimensions
  #     }
  #   }
  tags = {
    "Label" = "Messages Alert"
  }
}

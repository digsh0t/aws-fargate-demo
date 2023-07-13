resource "aws_sns_topic" "demo_topic" {
  name            = "demo-topic"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

resource "aws_sns_topic_subscription" "slack-endpoint" {
  endpoint               = var.slack_lambda_arn
  protocol               = "lambda"
  endpoint_auto_confirms = true
  topic_arn              = aws_sns_topic.demo_topic.arn
}

resource "aws_lambda_permission" "slack_lambda_invoke" {
  statement_id  = "sns_slackAllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.slack_lambda_arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.demo_topic.arn
}

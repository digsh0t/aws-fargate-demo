resource "aws_lambda_function" "noti_lambda" {
  function_name    = var.name
  description      = var.description
  filename         = var.artifact_file
  source_code_hash = filebase64sha256(var.artifact_file)
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = var.handler
  runtime          = var.runtime
  memory_size      = var.memory_size
  timeout          = var.timeout

  dynamic "environment" {
    for_each = (length(var.environment) > 0 ? [1] : [])
    content {
      variables = var.environment
    }
  }

  tags = var.tags
}

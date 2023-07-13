output "name" {
  description = "The name of the Lambda Function."
  value       = aws_lambda_function.noti_lambda.function_name
}

output "arn" {
  description = "The ARN identifying the Lambda Function."
  value       = aws_lambda_function.noti_lambda.arn
}

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway."
  value       = aws_lambda_function.noti_lambda.invoke_arn
}

resource "aws_iam_role" "lambda_exec_role" {
  name               = "NotiLambdaExecRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_exec_role_policy.json
}

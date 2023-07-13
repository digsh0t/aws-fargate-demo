data "aws_iam_policy_document" "lambda_exec_role_policy" {
  statement {
    sid    = "LambdaExecRolePolicy"
    effect = "Allow"
    principals {
      identifiers = [
        "lambda.amazonaws.com",
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
}

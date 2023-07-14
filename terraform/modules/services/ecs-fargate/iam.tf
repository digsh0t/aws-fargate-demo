resource "aws_iam_role" "ecs_task_role" {
  name               = "ecsTaskRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_iam_role_policy.json
}

resource "aws_iam_role" "ecs_task_exe_role" {
  name               = "ecsTaskExeRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exe_role_policy.json
}

resource "aws_iam_policy" "dynamodb" {
  name        = "task-policy-dynamodb"
  description = "Policy that allows access to DynamoDB"
  policy      = data.aws_iam_policy_document.ecs_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-task-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.dynamodb.arn
}

resource "aws_iam_role_policy_attachment" "ecs-exe-task-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_exe_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

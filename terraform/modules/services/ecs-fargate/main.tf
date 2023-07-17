resource "aws_ecs_cluster" "demo_ecs_cluster" {
  name = "demo-ecs-cluster"
}

resource "aws_cloudwatch_log_group" "demo_ecs_lg" {
  name = "demo_uvicorn_service"
}


resource "aws_ecs_task_definition" "demo_ecs_task" {
  network_mode             = "awsvpc"
  family                   = "demo_uvicorn_service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_exe_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode(
    [
      {
        name      = var.container_name
        image     = var.image_path
        essential = true
        environment = [
          for env_name, env_value in var.container_environment : {
            name  = env_name
            value = env_value
          }
        ]
        portMappings = [{
          protocol      = "tcp"
          containerPort = var.container_port
          hostPort      = var.container_port
        }]
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = "/ecs/${aws_cloudwatch_log_group.demo_ecs_lg.name}"
            awslogs-stream-prefix = "ecs"
            awslogs-region        = var.region
            awslogs-create-group  = true
          }
        }
      }
    ]
  )
}

resource "aws_security_group" "demo_ecs_task_sg" {
  name   = "ecs_task_sg"
  vpc_id = var.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = var.container_port
    to_port          = var.container_port
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ecs_service" "demo_ecs_service" {
  name                               = "demo-ecs-service"
  cluster                            = aws_ecs_cluster.demo_ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.demo_ecs_task.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.demo_ecs_task_sg.id]
    subnets          = var.subnet_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.aws_alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }
}

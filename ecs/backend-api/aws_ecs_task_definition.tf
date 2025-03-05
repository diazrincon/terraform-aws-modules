locals {
  base_container_definition = {
    name      = var.container_name
    image     = var.container_image
    essential = true
    portMappings = [
      {
        containerPort = 80
        protocol      = "tcp"
      }
    ]
    environment = [
      {
        name  = "TZ"
        value = "America/Los_Angeles"
      },
      {
        name  = "APP_CONFIGURATION_SECRET"
        value = var.app_configuration_secret
      }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.this.name
        "awslogs-region"        = "us-west-2"
        "awslogs-stream-prefix" = var.container_name
      }
    }
  }

  mount_point_container_definition = merge(local.base_container_definition, {
    mountPoints = [
      {
        containerPath = "/${var.container_name}/tmp"
        sourceVolume  = "shared"
      }
    ]
  })
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.ecs_task_definition_name
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.task_cpu
  memory = var.task_memory

  container_definitions = var.efs_file_system_id != "" ? jsonencode([local.mount_point_container_definition]) : jsonencode([local.base_container_definition])

  dynamic "volume" {
    for_each = var.efs_file_system_id != "" ? [1] : []
    content {
      name = "shared"
      efs_volume_configuration {
        file_system_id     = var.efs_file_system_id
        root_directory     = "/"
        transit_encryption = "ENABLED"
      }
    }
  }
}

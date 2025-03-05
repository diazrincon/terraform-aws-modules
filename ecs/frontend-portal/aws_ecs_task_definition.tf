# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
resource "aws_ecs_task_definition" "this" {
  family                   = var.ecs_task_definition_name
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.task_cpu
  memory = var.task_memory

  ephemeral_storage {
    size_in_gib = 21
  }

  container_definitions = jsonencode(
    [
      {
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
            name  = "APPLICATION_VERSION"
            value = var.application_version
          },
          {
            name  = "APPLICATION_HOST_NAME"
            value = var.application_host_name
          },
          {
            name  = "FRONTEND_BUCKET_PATH"
            value = var.frontend_bucket_path
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
        mountPoints = [
          {
            sourceVolume  = "nginx-storage"
            containerPath = "/srv"
          }
        ]
      }
    ]
  )

  volume {
    name = "nginx-storage"
  }
  
}

resource "aws_ecs_service" "this" {
  name            = var.ecs_service_name
  cluster         = data.aws_ecs_cluster.this.cluster_name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  propagate_tags = "SERVICE"

  network_configuration {
    subnets          = data.aws_subnets.private.ids
    security_groups  = var.security_groups
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.external.arn
    container_name   = var.container_name
    container_port   = 80
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.internal.arn
    container_name   = var.container_name
    container_port   = 80
  }
}

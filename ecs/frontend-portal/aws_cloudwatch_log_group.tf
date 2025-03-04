resource "aws_cloudwatch_log_group" "this" {
  name              = var.ecs_service_name
  retention_in_days = var.log_retention_days
}

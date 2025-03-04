resource "aws_lb_target_group" "this" {
  for_each    = var.listener_rules
  name        = each.value.target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.this.id

  dynamic "health_check" {
    for_each = each.value.health_check_enabled == true ? [1] : []
    content {
      path                = each.value.health_check_path
      interval            = 45
      timeout             = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
    }
  }
}

resource "aws_lb_listener_rule" "this" {
  for_each     = var.listener_rules
  listener_arn = data.aws_lb_listener.this.arn
  priority     = each.value.priority

  condition {
    host_header {
      values = [each.value.host_header]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }
}

resource "aws_lb_listener_certificate" "this" {
  for_each        = toset(var.additional_certificate_arns)
  listener_arn    = aws_lb_listener.this_https.arn
  certificate_arn = each.value
}

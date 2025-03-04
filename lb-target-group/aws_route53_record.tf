resource "aws_route53_record" "this" {
  for_each = var.listener_rules
  name     = each.value.host_header
  zone_id  = data.aws_route53_zone.this.zone_id
  type     = "A"
  alias {
    name                   = data.aws_lb.this.dns_name
    zone_id                = data.aws_lb.this.zone_id
    evaluate_target_health = false
  }
}

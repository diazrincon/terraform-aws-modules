resource "aws_route53_record" "this" {
  for_each = toset([for n in var.application_names : "${n}.${data.aws_route53_zone.public.name}"])
  name     = each.key
  zone_id  = data.aws_route53_zone.public.zone_id
  type     = "A"
  alias {
    name                   = data.aws_lb.this.dns_name
    zone_id                = data.aws_lb.this.zone_id
    evaluate_target_health = false
  }
}

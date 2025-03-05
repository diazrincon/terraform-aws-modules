output "certificate_arn" {
  value = aws_acm_certificate.this.arn
}

output "route53_zone_ids" {
  value = {
    public  = data.aws_route53_zone.public.zone_id
    private = data.aws_route53_zone.private[*].zone_id
  }
}

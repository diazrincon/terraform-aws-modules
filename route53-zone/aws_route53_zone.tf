# Route 53 Hosted Zone (Public or Private)
resource "aws_route53_zone" "this" {
  name    = var.domain_name
  comment = "Managed by Terraform"

  dynamic "vpc" {
    for_each = var.zone_type == "private" ? [1] : []
    content {
      vpc_id = var.vpc_id
    }
  }
}

data "aws_route53_zone" "public" {
  name         = var.public_zone_name
  private_zone = false
}

data "aws_route53_zone" "private" {
  count        = var.private_zone_name == "" ? 0 : 1
  name         = var.private_zone_name
  private_zone = true
}

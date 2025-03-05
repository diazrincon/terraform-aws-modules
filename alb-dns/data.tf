data "aws_lb" "this" {
  name = var.lb_name
}

data "aws_route53_zone" "public" {
  name         = var.public_zone_name
  private_zone = false
}

data "aws_vpc" "this" {
  id = var.vpc_id
}

data "aws_route53_zone" "this" {
  name         = var.zone_name
  private_zone = var.zone_type == "private" ? true : false
}

data "aws_lb" "this" {
  name = var.lb_name
}

data "aws_lb_listener" "this" {
  load_balancer_arn = data.aws_lb.this.arn
  port              = 443
}

resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = data.aws_subnets.this.ids

  access_logs {
    bucket  = var.access_logs_bucket
    prefix  = var.name
    enabled = true
  }
}

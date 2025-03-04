data "aws_vpc" "this" {
  id = var.vpc_id
}

data "aws_ecs_cluster" "this" {
  cluster_name = var.ecs_cluster_name
}

data "aws_lb_target_group" "external" {
  name = var.external_target_group_name
}

data "aws_lb_target_group" "internal" {
  name = var.internal_target_group_name
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  filter {
    name   = "tag:SubnetType"
    values = ["Private"]
  }
}

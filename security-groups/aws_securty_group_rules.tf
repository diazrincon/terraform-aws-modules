resource "aws_security_group_rule" "external_lb_ingress_http" {
  description       = "Allow inbound traffic from HTTP to the external load balancer on port 80"
  security_group_id = aws_security_group.external_lb1.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = local.allowed_external_cidr_blocks
}

resource "aws_security_group_rule" "external_lb_ingress_https" {
  description       = "Allow inbound traffic from HTTPS to the external load balancer on port 443"
  security_group_id = aws_security_group.external_lb2.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = local.allowed_external_cidr_blocks
}

resource "aws_security_group_rule" "external_lb_ingress_https_pl" {
  description       = "Allow inbound traffic from the prefix list to the external load balancer on port 443"
  security_group_id = aws_security_group.external_lb3.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  prefix_list_ids   = ["pl-0a1c0510a1c64e3a0"]
}

resource "aws_security_group_rule" "internal_lb_ingress_https" {
  description       = "Allow inbound traffic from the VPC to the internal load balancer on port 443"
  security_group_id = aws_security_group.internal_lb.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.this.cidr_block]
}

resource "aws_security_group_rule" "external_loadbalancer_to_tasks" {
  description              = "Allow inbound traffic from the external load balancer to the ECS tasks on port 80"
  security_group_id        = aws_security_group.tasks.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.external_lb1.id
}

resource "aws_security_group_rule" "internal_loadbalancer_to_tasks" {
  description              = "Allow inbound traffic from the internal load balancer to the ECS tasks on port 80"
  security_group_id        = aws_security_group.tasks.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.internal_lb.id
}

resource "aws_security_group_rule" "tasks_to_https" {
  description       = "Allow outbound traffic from the ECS tasks to the internet on port 443"
  security_group_id = aws_security_group.tasks.id
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", data.aws_vpc.this.cidr_block]
}

resource "aws_security_group_rule" "tasks_to_efs" {
  description       = "Allow outbound traffic from the ECS tasks to the EFS on port 2049"
  security_group_id = aws_security_group.tasks.id
  type              = "egress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.this.cidr_block]
}

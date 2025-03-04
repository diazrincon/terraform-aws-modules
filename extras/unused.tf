
resource "aws_security_group_rule" "alb_auth0_to_nodes" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "ALB to nodes"
  security_group_id        = aws_security_group.eks_node_shared.id
  source_security_group_id = aws_security_group.eks_alb_auth0.id
}

resource "aws_security_group_rule" "alb_vpn_to_nodes" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "ALB to nodes"
  security_group_id        = aws_security_group.eks_node_shared.id
  source_security_group_id = aws_security_group.eks_alb_vpn.id
}

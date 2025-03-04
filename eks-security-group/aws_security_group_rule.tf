# Ingress rule: Allow nodegroup nodes to communicate with control plane on port 443
resource "aws_security_group_rule" "cluster_sg_ingress_to_nodegroup_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster_sg.id
  source_security_group_id = aws_security_group.node_sg.id
  description              = "Allow nodegroup nodes to communicate with the control plane"
}

# Ingress rule: Allow control plane to communicate with nodegroup nodes on port 443
resource "aws_security_group_rule" "nodegroup_sg_ingress_to_control_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node_sg.id
  source_security_group_id = aws_security_group.cluster_sg.id
  description              = "Allow communication from the control plane"
}

# Ingress rule: Allow control plane to communicate with nodegroup nodes on port 443
resource "aws_security_group_rule" "nodegroup_sg_ingress_to_control_9443" {
  type                     = "ingress"
  from_port                = 9443
  to_port                  = 9443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node_sg.id
  source_security_group_id = aws_security_group.cluster_sg.id
  description              = "Allow communication from the control plane"
}

# Ingress rule: Allow nodegroup nodes to communicate with each other (all ports, all protocols)
resource "aws_security_group_rule" "nodegroup_sg_ingress_to_nodegroup" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1" # Allow all protocols and ports
  security_group_id        = aws_security_group.node_sg.id
  source_security_group_id = aws_security_group.node_sg.id
  description              = "Allow nodegroup nodes to communicate with each other"
}

# Ingress rule: Allow kubelet API communication on port 10250
resource "aws_security_group_rule" "nodegroup_sg_ingress_kubelet_api" {
  type              = "ingress"
  from_port         = 10250
  to_port           = 10250
  protocol          = "tcp"
  security_group_id = aws_security_group.node_sg.id
  cidr_blocks       = concat(var.public_access_cidrs_eks, [data.aws_vpc.this.cidr_block], var.bitbucket_outbound_cidrs)
  description       = "Allow kubelet API communication"
}

# Egress rule: Allow outbound traffic to SSM via HTTPS (port 443)
resource "aws_security_group_rule" "nodegroup_sg_egress_ssm" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.node_sg.id
  cidr_blocks       = ["0.0.0.0/0"] # Allow traffic to the internet (could be restricted to AWS public IPs)
  description       = "Allow nodegroup nodes outbound access to AWS SSM via HTTPS"
}

resource "aws_security_group_rule" "nodegroup_sg_egress_nfs" {
  type              = "egress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  security_group_id = aws_security_group.node_sg.id
  cidr_blocks       = [data.aws_vpc.this.cidr_block] # Allow traffic to the internet (could be restricted to AWS public IPs)
  description       = "Allow nodegroup nodes outbound access VPC NFS"
}

resource "aws_security_group_rule" "nodegroup_sg_egress_bitbucket" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.node_sg.id
  cidr_blocks       = var.bitbucket_inbound_cidrs
  description       = "Allow nodegroup nodes outbound access to Bitbucket via SSH"
}

resource "aws_security_group_rule" "nodegroup_sg_egress_dns_vpc" {
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  security_group_id = aws_security_group.node_sg.id
  cidr_blocks       = [data.aws_vpc.this.cidr_block]
  description       = "Allow DNS resolution within VPC"
}

resource "aws_security_group_rule" "nodegroup_sg_egress_mongodb_vpce" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node_sg.id
  source_security_group_id = aws_security_group.mongodb_vpce_sg.id
  description              = "Allow nodegroup outbound to MongoVPCE"
}

resource "aws_security_group_rule" "alb_ext_sg_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_ext_sg.id
  cidr_blocks       = var.public_access_cidrs_alb
  description       = "Allow HTTP from allowed cidrs"
}

resource "aws_security_group_rule" "alb_ext_sg_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_ext_sg.id
  cidr_blocks       = var.public_access_cidrs_alb
  description       = "Allow HTTPS from allowed cidrs"
}

resource "aws_security_group_rule" "alb_ext_mabl_sg_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_ext_sg.id
  cidr_blocks       = var.mabl_cidrs
  description       = "Allow HTTPS from allowed MABL cidrs"
}

resource "aws_security_group_rule" "alb_int_sg_egress_nodegroup" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_int_sg.id
  source_security_group_id = aws_security_group.node_sg.id
  description              = "Allow HTTP ALB to nodegroup"
}

resource "aws_security_group_rule" "nodegroup_sg_ingress_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node_sg.id
  source_security_group_id = aws_security_group.alb_int_sg.id
  description              = "Allow nodegroup nodes to receive ALB traffic"
}

resource "aws_security_group_rule" "mongodb_vpce_allow_eks_all" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  description              = "EKS to MongoDB VPCE"
  security_group_id        = aws_security_group.mongodb_vpce_sg.id
  source_security_group_id = aws_security_group.node_sg.id
}

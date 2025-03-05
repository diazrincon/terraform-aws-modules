resource "aws_security_group" "cluster_sg" {
  vpc_id      = data.aws_vpc.this.id
  description = "Additional Security Group for CP to Nodes"
  name        = "${var.cluster_name}-sg"
  tags = {
    Name                                        = "${var.cluster_name}-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group" "node_sg" {
  vpc_id      = data.aws_vpc.this.id
  description = "Additional SG for controlling nodes"
  name        = "${var.cluster_name}-node-sg"
  tags = {
    Name                                        = "${var.cluster_name}-node-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group" "alb_ext_sg" {
  vpc_id      = data.aws_vpc.this.id
  description = "Security Group for allowing external communication into the ALBs"
  name        = "${var.cluster_name}-alb-ext-sg"
  tags = {
    Name                                        = "${var.cluster_name}-alb-ext-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group" "alb_ext_mabl_sg" {
  vpc_id      = data.aws_vpc.this.id
  description = "Security Group for allowing MABL communication into the ALBs"
  name        = "${var.cluster_name}-alb-ext-mabl-sg"
  tags = {
    Name                                        = "${var.cluster_name}-alb-ext-mabl-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}


resource "aws_security_group" "alb_int_sg" {
  vpc_id      = data.aws_vpc.this.id
  description = "Security Group for allowing VPC communication from the ALBs"
  name        = "${var.cluster_name}-alb-int-sg"
  tags = {
    Name                                        = "${var.cluster_name}-alb-int-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}


resource "aws_security_group" "mongodb_vpce_sg" {
  vpc_id      = data.aws_vpc.this.id
  description = "Security Group for allowing MongoDB communication with the EKS Cluster"
  name        = "${var.cluster_name}-mongodb-vpce-sg"
  tags = {
    Name                                        = "${var.cluster_name}-mongodb-vpce-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

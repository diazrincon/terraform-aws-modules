resource "aws_security_group" "cluster_sg" {
  vpc_id      = data.aws_vpc.this.id
  description = "EKS created security group applied to ENI that is attached to EKS Control Plane master nodes, as well as any managed workloads."
  name        = "${var.cluster_name}-sg"
  # Egress rules without security group references
  egress = [
    {
      cidr_blocks      = []
      description      = "EKS Cluster outbound traffic"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    }
  ]

  # Ingress rules without security group references
  ingress = [
    {
      cidr_blocks      = []
      description      = "EKS Cluster inbound traffic"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    }
  ]

  tags = {
    Name                                        = "${var.cluster_name}-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group" "cluster_management_sg" {
  vpc_id      = data.aws_vpc.this.id
  name        = "${var.cluster_name}-allow-external-sg"
  description = "Management SG"
  egress      = []
  ingress = [
    {
      cidr_blocks      = var.public_access_cidrs
      description      = "Allow Public access to manage the SG"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks      = [data.aws_vpc.this.cidr_block]
      description      = "Allow VPC to manage EKS"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    }
  ]

  tags = {
    Name                                        = "${var.cluster_name}-allow-external-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group" "eks_node_shared" {
  vpc_id      = data.aws_vpc.this.id
  description = "EKS node shared security group"
  name        = "${var.cluster_name}-shared-node-sg"

  # Egress rules without security group references
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Egress NTP/TCP to internet"
      from_port        = 123
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 123
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Egress NTP/UDP to internet"
      from_port        = 123
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "udp"
      security_groups  = []
      self             = false
      to_port          = 123
    },
    {
      cidr_blocks      = ["104.192.136.0/21", "185.166.140.0/22", "18.205.93.0/25", "18.234.32.128/25", "13.52.5.0/25"]
      description      = "Bitbucket"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Egress all HTTPS to internet"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks      = [data.aws_vpc.this.cidr_block]
      description      = "Outbound EFS"
      from_port        = 2049
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 2049
    },
    {
      cidr_blocks      = [data.aws_vpc.this.cidr_block]
      description      = "Outbound MySql"
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3306
    },
    {
      cidr_blocks      = [data.aws_vpc.this.cidr_block]
      description      = "Outbound VPC Postgres"
      from_port        = 5432
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5432
    },
    {
      cidr_blocks      = [data.aws_vpc.this.cidr_block]
      description      = "Outbound VPC Redis"
      from_port        = 6379
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 6379
    },
    {
      cidr_blocks      = []
      description      = "Allow node to node egress"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = "Node to node CoreDNS"
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = true
      to_port          = 53
    },
    {
      cidr_blocks      = []
      description      = "Node to node CoreDNS"
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "udp"
      security_groups  = []
      self             = true
      to_port          = 53
    },
    {
      cidr_blocks      = []
      description      = "Allow all traffic to MongoVPCE"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = var.allow_egress_sgs
      self             = false
      to_port          = 0
    },
  ]

  # Ingress rules without security group references
  ingress = [
    {
      cidr_blocks      = []
      description      = "Allow ALB TargetGroup and Traffic"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [aws_security_group.eks_alb_auth0.id, aws_security_group.eks_alb_vpn.id]
      self             = false
      to_port          = 80
    },
    {
      cidr_blocks      = []
      description      = "Allow node to node ingress"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = "Node to node CoreDNS"
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = true
      to_port          = 53
    },
    {
      cidr_blocks      = []
      description      = "Node to node CoreDNS"
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "udp"
      security_groups  = []
      self             = true
      to_port          = 53
    }
  ]
  tags = {
    Name                                        = "${var.cluster_name}-shared-node-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group" "efs_nfs_sg" {
  name        = "${var.cluster_name}-efs-sg"
  description = "Security Group Attached to EFS"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    from_port   = 2049 # NFS port
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.this.cidr_block]
  }

  tags = {
    Name = "${var.cluster_name}-efs-sg"
  }
}

resource "aws_security_group" "eks_alb_vpn" {
  name        = "${var.cluster_name}-alb-vpn-sg"
  description = "Security Group Attached to External ALBs for VPN/Internet access"
  vpc_id      = data.aws_vpc.this.id

  tags = {
    Name = "${var.cluster_name}-alb-vpn-sg"
  }
}

resource "aws_security_group" "eks_alb_auth0" {
  name        = "${var.cluster_name}-alb-auth0-sg"
  description = "Security Group Attached to External ALBs for Auth0/MABL access"
  vpc_id      = data.aws_vpc.this.id

  tags = {
    Name = "${var.cluster_name}-alb-auth0-sg"
  }
}

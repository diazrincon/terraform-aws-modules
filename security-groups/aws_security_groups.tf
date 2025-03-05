locals {
  shared_egress_rules_for_lbs = [
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      description      = "Allow outbound traffic to HTTP"
      cidr_blocks      = [data.aws_vpc.this.cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      description      = "Allow outbound traffic to HTTPS"
      cidr_blocks      = [data.aws_vpc.this.cidr_block]
    }
  ]
}
resource "aws_security_group" "external_lb1" {
  name        = "external-lb-sg1"
  description = "Allow inbound traffic from HTTP to the external load balancer"
  vpc_id      = data.aws_vpc.this.id

  egress = local.shared_egress_rules_for_lbs
  tags = {
    Name = "external-lb-sg1"
  }
}

resource "aws_security_group" "external_lb2" {
  name        = "external-lb-sg2"
  description = "Allow inbound traffic from HTTPS to the external load balancer"
  vpc_id      = data.aws_vpc.this.id
  egress      = local.shared_egress_rules_for_lbs

  tags = {
    Name = "external-lb-sg2"
  }
}

resource "aws_security_group" "external_lb3" {
  name        = "external-lb-sg3"
  description = "Allow inbound traffic from Prefix Lists to the external load balancer"
  vpc_id      = data.aws_vpc.this.id
  egress      = local.shared_egress_rules_for_lbs

  tags = {
    Name = "external-lb-sg3"
  }
}

resource "aws_security_group" "internal_lb" {
  name        = "internal-lb-sg"
  description = "Allow inbound traffic from the VPC to the internal load balancer"
  vpc_id      = data.aws_vpc.this.id
  egress      = local.shared_egress_rules_for_lbs

  tags = {
    Name = "internal-lb-sg"
  }
}

resource "aws_security_group" "tasks" {
  name        = "tasks-sg"
  description = "Allow inbound traffic from the VPC to the ECS tasks"
  vpc_id      = data.aws_vpc.this.id
  tags = {
    Name = "tasks-sg"
  }
}

resource "aws_security_group" "efs" {
  name        = "nonprod-efs-sg"
  description = "Security group for the EFS file systems"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    from_port   = 2049 # NFS port
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.this.cidr_block]
  }

  tags = {
    Name = "nonprod-efs-sg"
  }
}

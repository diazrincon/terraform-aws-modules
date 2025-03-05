resource "aws_security_group" "this" {
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

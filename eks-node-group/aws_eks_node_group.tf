resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.base_name
  node_role_arn   = aws_iam_role.this.arn
  subnet_ids      = var.private_subnets
  #  ami_type        = "AL2023_x86_64_STANDARD"  # Requires user data in mime-multipart format
  capacity_type  = "ON_DEMAND"
  instance_types = var.instance_types

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Default"
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node_iam_policies
  ]

}

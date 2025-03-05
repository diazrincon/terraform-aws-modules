resource "aws_eks_access_policy_association" "workstation" {
  count         = var.workstation_access_entry.enabled ? 1 : 0
  cluster_name  = aws_eks_cluster.this.name
  policy_arn    = var.workstation_access_entry.policy_arn
  principal_arn = var.workstation_access_entry.role_arn

  access_scope {
    type = "cluster"
  }
}

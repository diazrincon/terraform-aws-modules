resource "aws_eks_access_entry" "workstation" {
  count         = var.workstation_access_entry.enabled ? 1 : 0
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = var.workstation_access_entry.role_arn
  type          = "STANDARD"
}

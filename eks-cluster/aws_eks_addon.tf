resource "aws_eks_addon" "amazon-cloudwatch-observability" {
  addon_name   = "amazon-cloudwatch-observability"
  cluster_name = aws_eks_cluster.this.name
}

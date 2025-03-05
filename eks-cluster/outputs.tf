output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_ca" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "openid_provider_arn" {
  value = aws_iam_openid_connect_provider.this[0].arn
}

output "service_ipv4_cidr" {
  value = aws_eks_cluster.this.kubernetes_network_config[0].service_ipv4_cidr
}

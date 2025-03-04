output "iam_role_arn" {
  value = aws_iam_role.this.arn
}

output "iam_role_name" {
  value = aws_iam_role.this.name
}

output "tag" {
  value = "kubernetes.io/cluster/${var.cluster_name}"
}

output "instance_profile" {
  value = aws_iam_instance_profile.this.arn
}

output "authconfig" {
  value = local.authconfig
}

output "ami_name" {
  value = data.aws_ami.eksal2023.name
}

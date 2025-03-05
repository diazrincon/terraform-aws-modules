data "aws_caller_identity" "current" {}

data "aws_ami" "eksal2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amazon-eks-node-al2023-x86_64-standard-${var.kubernetes_version}-v*"]
  }
}

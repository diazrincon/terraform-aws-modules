# Cluster Auto Scaler
data "aws_iam_policy_document" "cluster-autoscaler_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.this.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${data.aws_iam_openid_connect_provider.this.url}:sub"
      values   = ["system:serviceaccount:${local.cluster-autoscaler_service_account.namespace}:${local.cluster-autoscaler_service_account.name}"]
    }
  }
}

resource "aws_iam_policy" "cluster-autoscaler" {
  name   = "${var.cluster_name}-ClusterAutoScaler"
  policy = file("${path.module}/cluster-autoscaler-1.31.0.json")
}


resource "aws_iam_role" "cluster-autoscaler" {
  name               = "${var.cluster_name}-ClusterAutoScaler"
  assume_role_policy = data.aws_iam_policy_document.cluster-autoscaler_assume_role.json
}

resource "aws_iam_role_policy_attachment" "cluster-autoscaler" {
  role       = aws_iam_role.cluster-autoscaler.name
  policy_arn = aws_iam_policy.cluster-autoscaler.arn
}

resource "kubernetes_service_account" "cluster-autoscaler" {
  metadata {
    name      = local.cluster-autoscaler_service_account.name
    namespace = local.cluster-autoscaler_service_account.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.cluster-autoscaler.arn
      "meta.helm.sh/release-name" : local.cluster-autoscaler_service_account.name
      "meta.helm.sh/release-namespace" = local.cluster-autoscaler_service_account.namespace
    }
    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
    }
  }
}

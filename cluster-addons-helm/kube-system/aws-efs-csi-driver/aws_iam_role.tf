# https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/master/docs/iam-policy-example.json
data "aws_iam_policy_document" "aws-efs-csi-driver_assume_role" {
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
      values   = ["system:serviceaccount:${local.aws-efs-csi-driver_service_account.namespace}:${local.aws-efs-csi-driver_service_account.name}"]
    }
  }
}

resource "aws_iam_policy" "aws-efs-csi-driver" {
  name = "${var.cluster_name}-EKS_EFS_CSI_Driver_Policy"

  policy = file("${path.module}/aws-efs-csi-driver-v2.1.1.json")
}

resource "aws_iam_role" "aws-efs-csi-driver" {
  name               = "${var.cluster_name}-EKS_EFS_CSI_DriverRole"
  assume_role_policy = data.aws_iam_policy_document.aws-efs-csi-driver_assume_role.json
}

resource "aws_iam_role_policy_attachment" "aws-efs-csi-driver" {
  role       = aws_iam_role.aws-efs-csi-driver.name
  policy_arn = aws_iam_policy.aws-efs-csi-driver.arn
}

resource "kubernetes_service_account" "aws-efs-csi-driver" {
  metadata {
    name      = local.aws-efs-csi-driver_service_account.name
    namespace = local.aws-efs-csi-driver_service_account.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws-efs-csi-driver.arn
      "meta.helm.sh/release-name" : local.aws-efs-csi-driver_service_account.name
      "meta.helm.sh/release-namespace" = local.aws-efs-csi-driver_service_account.namespace
    }
    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
    }
  }
}



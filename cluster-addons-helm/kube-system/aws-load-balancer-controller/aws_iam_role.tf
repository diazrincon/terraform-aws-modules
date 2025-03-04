# https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.9.0/docs/install/iam_policy.json
data "aws_iam_policy_document" "aws_load_balancer_controller_assume_role" {
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
      values   = ["system:serviceaccount:${local.aws_load_balancer_controller_service_account.namespace}:${local.aws_load_balancer_controller_service_account.name}"]
    }
  }
}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name = "${var.cluster_name}-AWSLoadBalancerControllerIAMPolicy"

  policy = file("${path.module}/aws-load-balancer-controller-v2.10.0.json")
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  name               = "${var.cluster_name}-AmazonEKSLoadBalancerControllerRole"
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role.json
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}

resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = local.aws_load_balancer_controller_service_account.name
    namespace = local.aws_load_balancer_controller_service_account.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_load_balancer_controller.arn
      "meta.helm.sh/release-name" : local.aws_load_balancer_controller_service_account.name
      "meta.helm.sh/release-namespace" = local.aws_load_balancer_controller_service_account.namespace
    }
    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
    }
  }
}

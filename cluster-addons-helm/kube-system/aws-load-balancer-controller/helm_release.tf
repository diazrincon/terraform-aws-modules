resource "helm_release" "this" {
  name       = "aws-load-balancer-controller"
  namespace  = local.aws_load_balancer_controller_service_account.namespace
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.10.1"
  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = local.aws_load_balancer_controller_service_account.name
  }

  set {
    name  = "enableServiceMutatorWebhook"
    value = "false"
  }
}

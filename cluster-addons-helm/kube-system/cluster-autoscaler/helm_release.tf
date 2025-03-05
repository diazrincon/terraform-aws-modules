resource "helm_release" "this" {
  name            = "cluster-autoscaler"
  namespace       = local.cluster-autoscaler_service_account.namespace
  repository      = "https://kubernetes.github.io/autoscaler"
  chart           = "cluster-autoscaler"
  version         = "9.43.0"
  cleanup_on_fail = true

  set {
    name  = "rbac.serviceAccount.name"
    value = local.cluster-autoscaler_service_account.name
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "false"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoscalingGroups[0].name"
    value = var.cluster_asg_identifier
  }

  set {
    name  = "autoscalingGroups[0].maxSize"
    value = var.asg_maxsize
  }

  set {
    name  = "autoscalingGroups[0].minSize"
    value = var.asg_minsize
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "extraArgs.expander"
    value = "most-pods\\,least-nodes"
  }

  set {
    name  = "sslCertPath"
    value = "/etc/ssl/certs/ca-bundle.crt"
  }
}

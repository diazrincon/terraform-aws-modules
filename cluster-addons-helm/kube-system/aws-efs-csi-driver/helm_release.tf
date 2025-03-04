resource "helm_release" "this" {
  name       = "aws-efs-csi-driver"
  namespace  = local.aws-efs-csi-driver_service_account.namespace
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart      = "aws-efs-csi-driver"
  version    = "3.1.2"

  set {
    name  = "controller.serviceAccount.create"
    value = "false"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = local.aws-efs-csi-driver_service_account.name
  }
}

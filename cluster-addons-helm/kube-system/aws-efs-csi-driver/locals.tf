locals {
  aws-efs-csi-driver_service_account = {
    name      = "aws-efs-csi-driver-sa"
    namespace = "kube-system"
  }
}

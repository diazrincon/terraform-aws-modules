locals {
  cluster-autoscaler_service_account = {
    name      = "cluster-autoscaler"
    namespace = "kube-system"
  }
}

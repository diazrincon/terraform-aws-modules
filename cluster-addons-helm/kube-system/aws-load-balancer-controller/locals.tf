locals {
  aws_load_balancer_controller_service_account = {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
}

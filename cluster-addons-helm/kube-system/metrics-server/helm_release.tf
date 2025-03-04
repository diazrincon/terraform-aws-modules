resource "helm_release" "this" {
  name            = "metrics-server"
  namespace       = "kube-system"
  repository      = "https://kubernetes-sigs.github.io/metrics-server/"
  chart           = "metrics-server"
  version         = "3.12.2"
  cleanup_on_fail = true
}

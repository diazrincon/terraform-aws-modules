resource "helm_release" "this" {
  name            = "secrets-store-csi-driver"
  namespace       = "kube-system"
  repository      = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart           = "secrets-store-csi-driver"
  version         = "1.4.7"
  cleanup_on_fail = true

  set {
    name  = "syncSecret.enabled"
    value = "true"
  }
}

resource "helm_release" "this" {
  name            = "secrets-provider-aws"
  namespace       = "kube-system"
  repository      = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart           = "secrets-store-csi-driver-provider-aws"
  version         = "0.3.10"
  cleanup_on_fail = true
}

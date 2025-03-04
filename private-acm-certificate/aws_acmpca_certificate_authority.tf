# Create a private CA
resource "aws_acmpca_certificate_authority" "this" {
  type = "ROOT"

  certificate_authority_configuration {
    key_algorithm     = "RSA_2048"
    signing_algorithm = "SHA256WITHRSA"
    subject {
      common_name         = var.common_name
      organization        = var.organization
      organizational_unit = var.organizational_unit
      country             = var.country
      state               = var.state
      locality            = var.locality
    }
  }
}

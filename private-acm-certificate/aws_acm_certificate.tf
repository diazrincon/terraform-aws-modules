resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  certificate_authority_arn = aws_acmpca_certificate_authority.this.arn
}

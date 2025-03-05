resource "aws_iam_policy" "this" {
  name   = var.service_account_name
  policy = var.policy_json
}

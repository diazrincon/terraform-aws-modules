data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = var.base_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "node_iam_policies" {
  for_each   = var.node_iam_policies
  policy_arn = each.value
  role       = aws_iam_role.this.name
}

resource "aws_iam_instance_profile" "this" {
  name = var.base_name
  role = aws_iam_role.this.name
}

data "aws_iam_policy_document" "this" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateTags"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "this" {
  name   = var.base_name
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_instance_profile.this.name
  policy_arn = aws_iam_policy.this.arn
}

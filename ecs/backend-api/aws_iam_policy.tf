data "aws_iam_policy_document" "task_execution_role_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "task_role_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "additional_task_execution_policy" {
  count       = var.enable_additional_task_execution_policy == true ? 1 : 0
  name        = "${var.ecs_task_definition_name}-atep"
  description = "Additional Task Execution Policy"
  policy      = var.additional_task_execution_policy
}

resource "aws_iam_policy" "additional_task_policy" {
  count       = var.enable_additional_task_policy == true ? 1 : 0
  name        = "${var.ecs_task_definition_name}-atp"
  description = "Additional Task Policy"
  policy      = var.additional_task_policy
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${var.ecs_task_definition_name}-ter"
  assume_role_policy = data.aws_iam_policy_document.task_execution_role_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "task_execution_role_policy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "task_role" {
  name               = "${var.ecs_task_definition_name}-tr"
  assume_role_policy = data.aws_iam_policy_document.task_role_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "additional_task_execution_policy" {
  count      = var.enable_additional_task_execution_policy == true ? 1 : 0
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.additional_task_execution_policy[count.index].arn
}

resource "aws_iam_role_policy_attachment" "additional_task_policy" {
  count      = var.enable_additional_task_policy == true ? 1 : 0
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.additional_task_policy[count.index].arn
}

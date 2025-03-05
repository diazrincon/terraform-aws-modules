## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.85.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.85.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.additional_task__policy](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.additional_task_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.additional_task_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.additional_task_policy](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/ecs_cluster) | data source |
| [aws_iam_policy_document.task_execution_role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/iam_policy_document) | data source |
| [aws_lb_target_group.external](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/lb_target_group) | data source |
| [aws_lb_target_group.internal](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/lb_target_group) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/subnets) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_task_execution_policy"></a> [additional\_task\_execution\_policy](#input\_additional\_task\_execution\_policy) | n/a | `string` | `""` | no |
| <a name="input_additional_task_policy"></a> [additional\_task\_policy](#input\_additional\_task\_policy) | n/a | `string` | `""` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | n/a | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | n/a | `string` | n/a | yes |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | n/a | `number` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | n/a | `string` | n/a | yes |
| <a name="input_ecs_task_definition_name"></a> [ecs\_task\_definition\_name](#input\_ecs\_task\_definition\_name) | n/a | `string` | n/a | yes |
| <a name="input_efs_file_system_id"></a> [efs\_file\_system\_id](#input\_efs\_file\_system\_id) | n/a | `string` | n/a | yes |
| <a name="input_enable_additional_task_execution_policy"></a> [enable\_additional\_task\_execution\_policy](#input\_enable\_additional\_task\_execution\_policy) | n/a | `bool` | `false` | no |
| <a name="input_enable_additional_task_policy"></a> [enable\_additional\_task\_policy](#input\_enable\_additional\_task\_policy) | n/a | `bool` | `false` | no |
| <a name="input_external_target_group_name"></a> [external\_target\_group\_name](#input\_external\_target\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_internal_target_group_name"></a> [internal\_target\_group\_name](#input\_internal\_target\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `maps(string)` | n/a | yes |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | n/a | `number` | n/a | yes |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | n/a | `number` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.

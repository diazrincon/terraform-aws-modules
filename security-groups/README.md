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
| [aws_security_group.efs](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group) | resource |
| [aws_security_group.external_lb1](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group) | resource |
| [aws_security_group.external_lb2](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group) | resource |
| [aws_security_group.external_lb3](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group) | resource |
| [aws_security_group.internal_lb](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group) | resource |
| [aws_security_group.tasks](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.external_lb_ingress_http](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.external_lb_ingress_https](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.external_lb_ingress_https_pl](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.external_loadbalancer_to_tasks](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_lb_ingress_https](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_loadbalancer_to_tasks](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.tasks_to_efs](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.tasks_to_https](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/security_group_rule) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_sg"></a> [efs\_sg](#output\_efs\_sg) | n/a |
| <a name="output_external_lb_sg1"></a> [external\_lb\_sg1](#output\_external\_lb\_sg1) | n/a |
| <a name="output_external_lb_sg2"></a> [external\_lb\_sg2](#output\_external\_lb\_sg2) | n/a |
| <a name="output_external_lb_sg3"></a> [external\_lb\_sg3](#output\_external\_lb\_sg3) | n/a |
| <a name="output_internal_lb_sg"></a> [internal\_lb\_sg](#output\_internal\_lb\_sg) | n/a |
| <a name="output_tasks_sg"></a> [tasks\_sg](#output\_tasks\_sg) | n/a |

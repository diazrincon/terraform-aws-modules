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
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/lb_target_group) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/resources/route53_record) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/lb) | data source |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/lb_listener) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/route53_zone) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/5.85.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | n/a | `string` | n/a | yes |
| <a name="input_listener_rules"></a> [listener\_rules](#input\_listener\_rules) | n/a | <pre>map(object({<br/>    priority             = number<br/>    host_header          = string<br/>    target_group_name    = string<br/>    health_check_enabled = bool<br/>    health_check_path    = string<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | n/a | `string` | n/a | yes |
| <a name="input_zone_type"></a> [zone\_type](#input\_zone\_type) | n/a | `string` | `"public"` | no |

## Outputs

No outputs.

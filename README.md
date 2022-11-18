<!-- BEGIN_TF_DOCS -->
# terraform-aws-config-rules

GitHub: [StratusGrid/terraform-aws-config-rules](https://github.com/StratusGrid/terraform-aws-config-rules)

AWS Config rules module to put in standard policies

## Example Single Region Configuration:
```hcl
module "aws_config_rules_us_east_1" {
  source = "StratusGrid/config-rules/aws"
  version = "1.0.0"

  include_global_resource_rules = true #only include global resource on one region to prevent duplicate rules
  required_tags_enabled = true

  required_tags = { # Yes, the actual required format is tag#Key and tag#Value
    tag1Key   = "Provisioner"
    tag1Value = "Terraform"
    tag2Key   = "Customer"
    tag3Key   = "Application"
  }
}
```
---
## Example Multi Region Configuration:
```hcl
module "aws_config_rules_us_east_1" {
  source = "StratusGrid/config-rules/aws"
  version = "1.0.0"

  include_global_resource_rules = true #only include global resource on one region to prevent duplicate rules
  required_tags_enabled = true

  required_tags = { # Yes, the actual required format is tag#Key and tag#Value
    tag1Key   = "Provisioner"
    tag1Value = "Terraform"
    tag2Key   = "Customer"
    tag3Key   = "Application"
  }

  providers = {
    aws = "aws.us-east-1"
  }
}

module "aws_config_rules_us_east_2" {
  source = "StratusGrid/config-rules/aws"
  version = "1.0.0"

  required_tags_enabled = true

  required_tags = { # Yes, the actual required format is tag#Key and tag#Value
    tag1Key   = "Provisioner"
    tag1Value = "Terraform"
    tag2Key   = "Customer"
    tag3Key   = "Application"
  }

  providers = {
    aws = "aws.us-east-2"
  }
}

module "aws_config_rules_us_west_1" {
  source = "StratusGrid/config-rules/aws"
  version = "1.0.0"

  required_tags_enabled = true

  required_tags = { # Yes, the actual required format is tag#Key and tag#Value
    tag1Key   = "Provisioner"
    tag1Value = "Terraform"
    tag2Key   = "Customer"
    tag3Key   = "Application"
  }

  providers = {
    aws = "aws.us-west-1"
  }
}

module "aws_config_rules_us_west_2" {
  source = "StratusGrid/config-rules/aws"
  version = "1.0.0"

  required_tags_enabled = true

  required_tags = { # Yes, the actual required format is tag#Key and tag#Value
    tag1Key   = "Provisioner"
    tag1Value = "Terraform"
    tag2Key   = "Customer"
    tag3Key   = "Application"
  }

  providers = {
    aws = "aws.us-west-2"
  }
}
```
---

## Resources

| Name | Type |
|------|------|
| [aws_config_config_rule.iam_root_access_key_check](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.iam_user_mfa_enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.required_tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.root_account_mfa_enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_include_global_resource_rules"></a> [include\_global\_resource\_rules](#input\_include\_global\_resource\_rules) | True/False to add global resource rules to Config. Default is false | `string` | `false` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Map of tag keys, and optionally values, that are required. | `map(any)` | `{}` | no |
| <a name="input_required_tags_enabled"></a> [required\_tags\_enabled](#input\_required\_tags\_enabled) | True/False to add RequiredTags to Config. Default is false | `string` | `false` | no |

## Outputs

No outputs.

---

<span style="color:red">Note:</span> Manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->
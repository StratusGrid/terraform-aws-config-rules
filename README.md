<!-- BEGIN_TF_DOCS -->
<p align="center">                                                                                                                                            
                                                                                
  <img src="https://github.com/StratusGrid/terraform-readme-template/blob/main/header/stratusgrid-logo-smaller.jpg?raw=true" />
  <p align="center">                                                           
    <a href="https://stratusgrid.com/book-a-consultation">Contact Us</a> |                  
    <a href="https://stratusgrid.com/cloud-cost-optimization-dashboard">Stratusphere FinOps</a> |
    <a href="https://stratusgrid.com">StratusGrid Home</a> |
    <a href="https://stratusgrid.com/blog">Blog</a>
  </p>                    
</p>

 # terraform-aws-config-rules

 GitHub: [StratusGrid/terraform-aws-config-rules](https://github.com/StratusGrid/terraform-aws-config-rules)

 AWS Config rules module to put in standard policies

 Note: Config Rule requires an existing Configuration Recorder to be present.
 
 ## Example Single Region Configuration:
 ```hcl
 module "aws_config_rules_us_east_1" {
  source = "StratusGrid/config-rules/aws"
  # StratusGrid recommends pinning every module to a specific version
  version = "x.x.x"

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
  # StratusGrid recommends pinning every module to a specific version
  version = "x.x.x"

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
  # StratusGrid recommends pinning every module to a specific version
  version = "x.x.x"

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
  # StratusGrid recommends pinning every module to a specific version
  version = "x.x.x"

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
  # StratusGrid recommends pinning every module to a specific version
  version = "x.x.x"

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
| [aws_config_config_rule.aws_managed_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.custom_managed_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |

 ## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_managed_rules"></a> [aws\_managed\_rules](#input\_aws\_managed\_rules) | A list of AWS Managed Rules that should be enabled on the account.<br><br>See the following for a list of possible rules to enable:<br>https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html | <pre>map(object({<br>    description      = string<br>    identifier       = string<br>    input_parameters = any<br>  }))</pre> | `{}` | no |
| <a name="input_custom_managed_rules"></a> [custom\_managed\_rules](#input\_custom\_managed\_rules) | A list of AWS Managed Custom Rules that should be enabled on the account.<br><br>Reference<br>https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_develop-rules.html | `map(any)` | `{}` | no |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(any)` | <pre>{<br>  "Developer": "StratusGrid",<br>  "Provisioner": "Terraform"<br>}</pre> | no |

 ## Outputs

No outputs.

 ---

 <span style="color:red">Note:</span> Manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->
variable "enable_default_aws_managed_rules" {
  description = "True/False to add default Config Rules. Default is true"
  type        = bool
  default     = true
}

variable "required_tags_enabled" {
  description = "True/False to add RequiredTags to Config. Default is false"
  type        = bool
  default     = false
}

variable "required_tags" {
  description = "Map of tag keys, and optionally values, that are required."
  type        = map(any)
  default     = {}
}

variable "input_tags" {
  description = "Map of tags to apply to resources"
  type        = map(any)
  default = {
    Developer   = "StratusGrid"
    Provisioner = "Terraform"
  }
}

variable "aws_managed_rules" {
  description = <<-DOC
    A list of AWS Managed Rules that should be enabled on the account.

    See the following for a list of possible rules to enable:
    https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html
  DOC
  type = map(object({
    description      = string
    identifier       = string
    input_parameters = any
  }))
  default = {}
}

variable "custom_managed_rules" {
  description = <<-DOC
    A list of AWS Managed Custom Rules that should be enabled on the account.

    Reference
    https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_develop-rules.html
  DOC
  type        = map(any)
  default     = {}
}
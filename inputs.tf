### Commented out name_prefix and name_suffix since there can only be one config stream and you don't see the name anywhere
### When you have names and the name changes, it requires manual intervention.

# variable "name_prefix" {
#   description = "String to prefix on object names"
#   type = "string"
# }

# variable "name_suffix" {
#   description = "String to append to object names. This is optional, so start with dash if using"
#   type = "string"
#   default = ""
# }

# Deprecated in version ??

# variable "include_global_resource_rules" {
#   description = "True/False to add global resource rules to Config. Default is false"
#   type        = string
#   default     = false
# }

# Deprecated in version ??
# variable "required_tags_enabled" {
#   description = "True/False to add RequiredTags to Config. Default is false"
#   type        = string
#   default     = false
# }

# Deprecated in version ??
# variable "required_tags" {
#   description = "Map of tag keys, and optionally values, that are required."
#   type        = map(any)
#   default     = {}
# }

# Deprecated in version ??
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
  type = map(object({
    description      = string
    
  }))
  default = {}
}

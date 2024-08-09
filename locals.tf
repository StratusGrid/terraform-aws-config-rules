# Default AWS Manage Rules
locals {
  default_aws_managed_rules = var.enable_default_aws_managed_rules == true ? {
    root-account-mfa-enabled = {
      description      = "Checks if the root user of your AWS account requires multi-factor authentication for console sign-in."
      identifier       = "ROOT_ACCOUNT_MFA_ENABLED"
      input_parameters = {}
    }
    iam-root-access-key-check = {
      description      = "Checks if the root user access key is available."
      identifier       = "IAM_ROOT_ACCESS_KEY_CHECK"
      input_parameters = {}
    }
    iam-user-mfa-enabled = {
      description      = "Checks if the AWS Identity and Access Management (IAM) users have multi-factor authentication (MFA) enabled."
      identifier       = "IAM_USER_MFA_ENABLED"
      input_parameters = {}
    }
  } : {}

  aws_managed_rule_required_tags = var.required_tags_enabled == true ? {
    required-tags = {
      description      = "Checks if your resources have the tags that you specify."
      identifier       = "REQUIRED_TAGS"
      input_parameters = var.required_tags
    }
  } : {}

  # Merge the default rules with the user defined rules
  aws_managed_rules = merge(var.aws_managed_rules, local.default_aws_managed_rules, local.aws_managed_rule_required_tags)

}

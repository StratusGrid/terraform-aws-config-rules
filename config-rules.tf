# ### Global ###
# # Root user account config rules

# Deprecated in version 2.0.0, remove from code in next release
# #https://docs.aws.amazon.com/config/latest/developerguide/root-account-mfa-enabled.html
# resource "aws_config_config_rule" "root_account_mfa_enabled" {
#   name  = "root-account-mfa-enabled"
#   count = var.include_global_resource_rules ? 1 : 0

#   source {
#     owner             = "AWS"
#     source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
#   }

#   maximum_execution_frequency = "TwentyFour_Hours"

#   tags = local.common_tags
# }


# Deprecated in version 2.0.0, remove from code in next release
# #https://docs.aws.amazon.com/config/latest/developerguide/iam-root-access-key-check.html
# resource "aws_config_config_rule" "iam_root_access_key_check" {
#   name  = "iam-root-access-key-check"
#   count = var.include_global_resource_rules ? 1 : 0

#   source {
#     owner             = "AWS"
#     source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
#   }

#   maximum_execution_frequency = "TwentyFour_Hours"

#   tags = local.common_tags
# }


# Deprecated in version 2.0.0, remove from code in next release
# #https://docs.aws.amazon.com/config/latest/developerguide/iam-user-mfa-enabled.html
# resource "aws_config_config_rule" "iam_user_mfa_enabled" {
#   name  = "iam-user-mfa-enabled"
#   count = var.include_global_resource_rules ? 1 : 0

#   source {
#     owner             = "AWS"
#     source_identifier = "IAM_USER_MFA_ENABLED"
#   }

#   maximum_execution_frequency = "TwentyFour_Hours"

#   tags = local.common_tags
# }

# Deprecated in version 2.0.0, remove from code in next release
# ### Regional Rules ###
# # https://docs.aws.amazon.com/config/latest/developerguide/required-tags.html
# resource "aws_config_config_rule" "required_tags" {
#   name  = "required-tags"
#   count = var.required_tags_enabled ? 1 : 0

#   source {
#     owner             = "AWS"
#     source_identifier = "REQUIRED_TAGS"
#   }

#   input_parameters = jsonencode(var.required_tags)

#   tags = local.common_tags
# }


# AWS Managed rules could be a combination of Global and Regional rules for list of available rules check
# https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html
resource "aws_config_config_rule" "aws_managed_rules" {
  for_each = var.aws_managed_rules != null ? var.aws_managed_rules : {}

  name        = each.key
  description = each.value.description

  source {
    owner             = "AWS"
    source_identifier = each.value.identifier
  }

  input_parameters = length(each.value.input_parameters) > 0 ? jsonencode(each.value.input_parameters) : null

  tags = local.common_tags
}

# AWS Managed rules could be a combination of Global and Regional rules for list of available rules check
# https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html
resource "aws_config_config_rule" "custom_managed_rules" {
  for_each = var.custom_managed_rules != null ? var.custom_managed_rules : {}

  name        = each.key
  description = each.value.description

  scope {
    compliance_resource_id    = lookup(each.value.scope, "compliance_resource_id", null)
    compliance_resource_types = lookup(each.value.scope, "compliance_resource_types", null)
    tag_key                   = lookup(each.value.scope, "tag_key", null)
    tag_value                 = lookup(each.value.scope, "tag_value", null)
  }

  source {
    owner = "CUSTOM_POLICY"
    dynamic "source_detail" {
      for_each = each.value.source.source_detail != null ? [each.value.source.source_detail] : []
      content {
        maximum_execution_frequency = source_detail.value.message_type == "ScheduledNotification" ? source_detail.value.maximum_execution_frequency : null
        # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule#message_type
        message_type = source_detail.value.message_type
      }
    }

    dynamic "custom_policy_details" {
      for_each = each.value.source.custom_policy_details != null ? [each.value.source.custom_policy_details] : []
      content {
        enable_debug_log_delivery = lookup(custom_policy_details.value, "enable_debug_log_delivery", null)
        policy_runtime            = custom_policy_details.value.policy_runtime
        policy_text               = custom_policy_details.value.policy_text
      }
    }
  }

  tags = local.common_tags
}

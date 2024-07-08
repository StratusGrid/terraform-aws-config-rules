# ### Global ###
# # Root user account config rules

# Deprecated in version ??

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


# Deprecated in version ??
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


# Deprecated in version ??

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

# Deprecated in version ??
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
}

# # AWS Managed rules could be a combination of Global and Regional rules for list of available rules check
# # https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html
# resource "aws_config_config_rule" "custom_managed_rules" {
#   for_each = var.custom_managed_rules != null ? var.custom_managed_rules : {}

#   name        = each.key
#   description = each.value.description

#   source {
#     owner = "CUSTOM_POLICY"

#     dynamic "source_detail" {
#       for_each = each.value.source_detail
#       content {
#         maximum_execution_frequency = each.value.message_type == "ScheduledNotification" ? each.value.maximum_execution_frequency : null
#         message_type                = each.value.message_type
#       }
#     }

#     dynamic "custom_policy_details" {
#       for_each = each.value.custom_policy_details
#       content {
#         enable_debug_log_delivery = each.value.enable_debug_log_delivery
#         policy_runtime  = each.value.policy_runtime 
#         policy_text = each.value.policy_text
#       }
#     }
#   }
# }


resource "aws_config_config_rule" "example" {
  name = "example"

  source {
    owner = "CUSTOM_POLICY"

    source_detail {
      message_type = "ConfigurationItemChangeNotification"
    }

    custom_policy_details {
      policy_runtime = "guard-2.x.x"
      policy_text    = <<EOF
      rule tableisactive when
          resourceType == "AWS::DynamoDB::Table" {
          configuration.tableStatus == ['ACTIVE']
      }

      rule checkcompliance when
          resourceType == "AWS::DynamoDB::Table"
          tableisactive {
              supplementaryConfiguration.ContinuousBackupsDescription.pointInTimeRecoveryDescription.pointInTimeRecoveryStatus == "ENABLED"
      }
EOF                    
    }
  }
}
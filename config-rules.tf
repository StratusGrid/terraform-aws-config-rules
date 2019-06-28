### Global ###
# Root user account config rules

#https://docs.aws.amazon.com/config/latest/developerguide/root-account-mfa-enabled.html
resource "aws_config_config_rule" "root_account_mfa_enabled" {
  name = "root-account-mfa-enabled"
  count = "${var.include_global_resource_rules ? 1 : 0}"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

    maximum_execution_frequency = "TwentyFour_Hours"
}

#https://docs.aws.amazon.com/config/latest/developerguide/iam-root-access-key-check.html
resource "aws_config_config_rule" "iam_root_access_key_check" {
  name = "iam-root-access-key-check"
  count = "${var.include_global_resource_rules ? 1 : 0}"

  source {
    owner             = "AWS"
    source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
  }

  maximum_execution_frequency = "TwentyFour_Hours"
}

#https://docs.aws.amazon.com/config/latest/developerguide/iam-user-mfa-enabled.html
resource "aws_config_config_rule" "iam_user_mfa_enabled" {
  name = "iam-user-mfa-enabled"
  count = "${var.include_global_resource_rules ? 1 : 0}"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }

  maximum_execution_frequency = "TwentyFour_Hours"
}


### Regional Rules ###
# https://docs.aws.amazon.com/config/latest/developerguide/required-tags.html
resource "aws_config_config_rule" "required_tags" {
  name = "required-tags"
  count = "${var.required_tags_enabled ? 1 : 0}"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"

  }

  input_parameters = "${jsonencode(var.required_tags)}"
}






### For Possible implementation later ###
# resource "aws_config_config_rule" "s3_bucket_public_read_prohibited" {
#   name = "s3-bucket-public-read-prohibited"

#   source {
#     owner             = "AWS"
#     source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
#   }
# }

# resource "aws_config_config_rule" "s3_bucket_public_write_prohibited" {
#   name = "s3-bucket-public-write-prohibited"

#   source {
#     owner             = "AWS"
#     source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
#   }
# }

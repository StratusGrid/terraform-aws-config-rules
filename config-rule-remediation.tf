resource "aws_config_remediation_configuration" "acm_certificate_expiration_check" {
  count = var.sns_notifications ? 1 : 0
  config_rule_name = aws_config_config_rule.acm_certificate_expiration_check.name
  resource_type    = "AWS::ACM::Certificate"
  target_type      = "SSM_DOCUMENT"
  target_id        = "AWS-PublishSNSNotification"
  target_version   = "1"

  parameter {
    name         = "AutomationAssumeRole"
    static_value = var.automation_role
  }
  parameter {
    name           = "TopicARN"
    resource_value = var.topic_arn
  }
  parameter {
    name         = "Message"
    static_value = var.message
  }
}
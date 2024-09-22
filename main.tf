#Create Control Tower
resource "aws_controltower_landing_zone" "ct_lz" {
  depends_on = [
    aws_iam_role_policy_attachment.ct_admin_managed_policy,
    aws_iam_role_policy_attachment.ct_config_aggregator_role_policy,
    aws_iam_role_policy.ct_stack_set_role_policy,
    aws_iam_role_policy.ct_cloudtrail_role_policy,
    aws_kms_key_policy.ct_kms_policy
  ]
  version = var.ct_version
  manifest_json = jsonencode({
    governedRegions       = var.ct_governed_regions
    organizationStructure = var.ct_organisation_structure
    centralizedLogging = {
      accountId = aws_organizations_account.log_archive.id
      configurations = {
        loggingBucket = {
          retentionDays = var.ct_logging_bucket_retention_days
        }
        accessLoggingBucket = {
          retentionDays = var.ct_access_logging_bucket_retention_days
        }
        kmsKeyArn = aws_kms_key.ct_kms_key.arn
      }
      enabled = var.ct_centralized_logging_enabled
    }
    securityRoles = {
      accountId = aws_organizations_account.security_tooling.id
    }
    accessManagement = {
      enabled = var.ct_access_management_enabled
    }
  })
  tags = var.tags
}

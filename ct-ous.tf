resource "aws_organizations_organization" "mgmt" {
  aws_service_access_principals = var.org_aws_service_access_principals
  enabled_policy_types          = var.org_enabled_policy_type
  feature_set                   = var.org_feature_set
}

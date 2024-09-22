resource "aws_organizations_account" "log_archive" {
  depends_on = [aws_organizations_organization.mgmt]
  name       = var.log_archive_account_name
  email      = var.log_archive_email_id
  tags       = var.tags
}

resource "aws_organizations_account" "security_tooling" {
  depends_on = [aws_organizations_organization.mgmt]
  name       = var.security_tooling_account_name
  email      = var.security_tooling_email_id
  tags       = var.tags
}

module "controltower" {
  source = "../"

  ct_home_region                          = "eu-north-1"
  ct_governed_regions                     = ["eu-central-1", "us-east-1", "eu-north-1"]
  ct_logging_bucket_retention_days        = "10" #https://github.com/hashicorp/terraform-provider-aws/issues/35763
  ct_access_logging_bucket_retention_days = "10" #https://github.com/hashicorp/terraform-provider-aws/issues/35763
  management_account_id                   = "11111111111"
  log_archive_account_email_id            = "your-email+log-archive@example.com"
  audit_account_email_id                  = "your-email+security-tooling@example.com"
  aft_mgmt_email_id                       = "your-email+aft-mgmt@example.com"
  tags = {
    managedBy = "terraform"
  }
}

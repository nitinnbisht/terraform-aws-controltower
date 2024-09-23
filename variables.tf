variable "ct_home_region" {
  type        = string
  description = "Value of the region where AWS Control Tower is deployed"
}

variable "management_account_id" {
  description = "The ID of the management account in which AWS Control Tower will be set up."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resources"
  default = {
    managedBy   = "terraform"
    environment = "prd"
  }
}

# KMS Variables
variable "kms_alias_names" {
  type        = string
  description = "KMS alias to use for Control Tower"
  default     = "alias/controltower"
}

# Org and Account Variables
variable "log_archive_account_name" {
  type        = string
  description = "The name of the Log Archive AWS Organization account"
  default     = "Log Archive"
}

variable "log_archive_account_email_id" {
  type        = string
  description = "The email ID for the Log Archive AWS Organization account"
}

variable "audit_account_name" {
  type        = string
  description = "The name of the Security Tooling (Audit) AWS Organization account"
  default     = "Audit"
}

variable "audit_account_email_id" {
  type        = string
  description = "The email ID for the Security Tooling (Audit) AWS Organization account"
}

variable "org_aws_service_access_principals" {
  description = "List of AWS service principal names for which you want to enable integration with your organization"
  type        = list(string)
  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com",
    "controltower.amazonaws.com",
    "guardduty.amazonaws.com",
    "securityhub.amazonaws.com",
    "reporting.trustedadvisor.amazonaws.com",
    "account.amazonaws.com",
    "servicecatalog.amazonaws.com",
    "member.org.stacksets.cloudformation.amazonaws.com"
  ]
}

variable "org_enabled_policy_type" {
  description = "List of Organizations policy types to enable in the Organization root"
  type        = list(string)
  default = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY",
    "AISERVICES_OPT_OUT_POLICY"
  ]
}

variable "org_feature_set" {
  description = "The feature set for the organization"
  type        = string
  default     = "ALL"
}

# Control Tower Variables
variable "ct_organisation_structure" {
  type        = map(map(string))
  description = "Control Tower organisation structure"
  default = {
    security = {
      name = "Security"
    }
    sandbox = {
      name = "Sandbox"
    }
  }
}

variable "ct_governed_regions" {
  type        = list(string)
  description = "List of regions where Control Tower is enabled"
}

variable "ct_version" {
  type        = string
  description = "Control Tower version"
  default     = "3.3"
}

# https://github.com/hashicorp/terraform-provider-aws/issues/35763
variable "ct_logging_bucket_retention_days" {
  type        = number
  description = "The number of days to retain the logging bucket"
}

variable "ct_access_logging_bucket_retention_days" {
  type        = number
  description = "The number of days to retain the access logging bucket"
}

variable "ct_centralized_logging_enabled" {
  type        = bool
  description = "Whether to enable centralized logging"
  default     = true
}

variable "ct_access_management_enabled" {
  type        = bool
  description = "Whether to enable access management"
  default     = false
}

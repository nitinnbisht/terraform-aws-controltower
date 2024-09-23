# terraform-aws-controltower
This Terraform module provisions an AWS Control Tower Landing Zone, which provides a well-architected, multi-account AWS environment based on AWS best practices. It enables account governance, centralized logging, security configurations, and more, automating the deployment and management of AWS Control Tower.

## Features
- Automates the creation of AWS Control Tower Landing Zone
- Supports provisioning of Organizational Units (OUs) and foundational Accounts
- Sets up essential IAM roles and permissions
- Integrates with AWS KMS for encryption

## Usage
Here is a basic example of how to use this module:

```hcl
module "control_tower" {
  source  = "github.com/nitinnbisht/terraform-aws-controltower"

  ct_home_region                          = "eu-north-1"
  ct_governed_regions                     = ["eu-central-1", "us-east-1", "eu-north-1"]
  ct_logging_bucket_retention_days        = "10"
  ct_access_logging_bucket_retention_days = "10"
  management_account_id                   = "11111111111"
  log_archive_account_email_id            = "your-email+log-archive@example.com"
  audit_account_email_id                  = "your-email+security-tooling@example.com"
  aft_mgmt_email_id                       = "your-email+aft-mgmt@example.com"
  tags = {
    managedBy = "terraform"
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.65.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.65.0 |

## Resources

| Name | Type |
|------|------|
| [aws_controltower_landing_zone.ct_lz](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_landing_zone) | resource |
| [aws_iam_role.ct_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ct_cloudtrail_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ct_config_aggregator_role_for_organizations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ct_stack_set_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ct_admin_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ct_cloudtrail_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ct_stack_set_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ct_admin_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ct_config_aggregator_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.ct_kms_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.ct_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.ct_kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_organizations_account.log_archive](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_account.security_tooling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organization.mgmt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audit_account_email_id"></a> [audit\_account\_email\_id](#input\_audit\_account\_email\_id) | The email ID for the Security Tooling (Audit) AWS Organization account | `string` | n/a | yes |
| <a name="input_audit_account_name"></a> [audit\_account\_name](#input\_audit\_account\_name) | The name of the Security Tooling (Audit) AWS Organization account | `string` | `"Audit"` | no |
| <a name="input_ct_access_logging_bucket_retention_days"></a> [ct\_access\_logging\_bucket\_retention\_days](#input\_ct\_access\_logging\_bucket\_retention\_days) | The number of days to retain the access logging bucket | `number` | n/a | yes |
| <a name="input_ct_access_management_enabled"></a> [ct\_access\_management\_enabled](#input\_ct\_access\_management\_enabled) | Whether to enable access management | `bool` | `false` | no |
| <a name="input_ct_centralized_logging_enabled"></a> [ct\_centralized\_logging\_enabled](#input\_ct\_centralized\_logging\_enabled) | Whether to enable centralized logging | `bool` | `true` | no |
| <a name="input_ct_governed_regions"></a> [ct\_governed\_regions](#input\_ct\_governed\_regions) | List of regions where Control Tower is enabled | `list(string)` | n/a | yes |
| <a name="input_ct_home_region"></a> [ct\_home\_region](#input\_ct\_home\_region) | Value of the region where AWS Control Tower is deployed | `string` | n/a | yes |
| <a name="input_ct_logging_bucket_retention_days"></a> [ct\_logging\_bucket\_retention\_days](#input\_ct\_logging\_bucket\_retention\_days) | The number of days to retain the logging bucket | `number` | n/a | yes |
| <a name="input_ct_organisation_structure"></a> [ct\_organisation\_structure](#input\_ct\_organisation\_structure) | Control Tower organisation structure | `map(map(string))` | <pre>{<br>  "sandbox": {<br>    "name": "Sandbox"<br>  },<br>  "security": {<br>    "name": "Security"<br>  }<br>}</pre> | no |
| <a name="input_ct_version"></a> [ct\_version](#input\_ct\_version) | Control Tower version | `string` | `"3.3"` | no |
| <a name="input_kms_alias_names"></a> [kms\_alias\_names](#input\_kms\_alias\_names) | KMS alias to use for Control Tower | `string` | `"alias/controltower"` | no |
| <a name="input_log_archive_account_email_id"></a> [log\_archive\_account\_email\_id](#input\_log\_archive\_account\_email\_id) | The email ID for the Log Archive AWS Organization account | `string` | n/a | yes |
| <a name="input_log_archive_account_name"></a> [log\_archive\_account\_name](#input\_log\_archive\_account\_name) | The name of the Log Archive AWS Organization account | `string` | `"Log Archive"` | no |
| <a name="input_management_account_id"></a> [management\_account\_id](#input\_management\_account\_id) | The ID of the management account in which AWS Control Tower will be set up. | `string` | n/a | yes |
| <a name="input_org_aws_service_access_principals"></a> [org\_aws\_service\_access\_principals](#input\_org\_aws\_service\_access\_principals) | List of AWS service principal names for which you want to enable integration with your organization | `list(string)` | <pre>[<br>  "cloudtrail.amazonaws.com",<br>  "config.amazonaws.com",<br>  "sso.amazonaws.com",<br>  "controltower.amazonaws.com",<br>  "guardduty.amazonaws.com",<br>  "securityhub.amazonaws.com",<br>  "reporting.trustedadvisor.amazonaws.com",<br>  "account.amazonaws.com",<br>  "servicecatalog.amazonaws.com",<br>  "member.org.stacksets.cloudformation.amazonaws.com"<br>]</pre> | no |
| <a name="input_org_enabled_policy_type"></a> [org\_enabled\_policy\_type](#input\_org\_enabled\_policy\_type) | List of Organizations policy types to enable in the Organization root | `list(string)` | <pre>[<br>  "SERVICE_CONTROL_POLICY",<br>  "TAG_POLICY",<br>  "AISERVICES_OPT_OUT_POLICY"<br>]</pre> | no |
| <a name="input_org_feature_set"></a> [org\_feature\_set](#input\_org\_feature\_set) | The feature set for the organization | `string` | `"ALL"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the resources | `map(string)` | <pre>{<br>  "environment": "prd",<br>  "managedBy": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_controltower_arn"></a> [controltower\_arn](#output\_controltower\_arn) | The ARN of the landing zone |
| <a name="output_controltower_drift_status"></a> [controltower\_drift\_status](#output\_controltower\_drift\_status) | The drift status of the landing zone |
| <a name="output_controltower_version"></a> [controltower\_version](#output\_controltower\_version) | The version of the landing zone |
| <a name="output_organization_arn"></a> [organization\_arn](#output\_organization\_arn) | The ARN of the organization |
<!-- END_TF_DOCS -->

## Limitations
- AWS Control Tower only supports specific regions.
- Ensure your AWS organization does not have existing service control policies (SCPs) that conflict with Control Tower guardrails.

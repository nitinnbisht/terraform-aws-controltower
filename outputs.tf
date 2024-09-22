output "organization_arn" {
  value       = aws_organizations_organization.mgmt.arn
  description = "The ARN of the organization"
}

output "controltower_drift_status" {
  value       = aws_controltower_landing_zone.ct_lz.drift_status
  description = "The drift status of the landing zone"
}

output "controltower_arn" {
  value       = aws_controltower_landing_zone.ct_lz.arn
  description = "The ARN of the landing zone"
}

output "controltower_version" {
  value       = aws_controltower_landing_zone.ct_lz.version
  description = "The version of the landing zone"
}

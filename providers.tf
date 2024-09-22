# Terraform settings block
terraform {
  required_version = ">= 1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.65.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = var.ct_home_region
}

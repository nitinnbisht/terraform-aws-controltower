# Get the current region
data "aws_region" "current" {}

# Create a new KMS key without an initial policy
resource "aws_kms_key" "ct_kms_key" {
  description             = "KMS key for AWS Control Tower"
  enable_key_rotation     = true
  deletion_window_in_days = 30
  tags                    = var.tags
}

resource "aws_kms_alias" "ct_kms_key_alias" {
  name          = var.kms_alias_names
  target_key_id = aws_kms_key.ct_kms_key.key_id
}

# Attach the full policy to the KMS key
resource "aws_kms_key_policy" "ct_kms_policy" {
  key_id = aws_kms_key.ct_kms_key.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "ControlTowerKMSPolicy",
    Statement = [
      {
        Sid    = "Allow Administration of the key",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${var.management_account_id}:root"
        },
        Action   = "kms:*",
        Resource = "arn:aws:kms:${data.aws_region.current.name}:${var.management_account_id}:key/${aws_kms_key.ct_kms_key.key_id}"
      },
      {
        Sid    = "Allow Config to use KMS for encryption",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        Resource = "arn:aws:kms:${data.aws_region.current.name}:${var.management_account_id}:key/${aws_kms_key.ct_kms_key.key_id}"
      },
      {
        Sid    = "Allow CloudTrail to use KMS for encryption",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action = [
          "kms:GenerateDataKey*",
          "kms:Decrypt"
        ],
        Resource = "arn:aws:kms:${data.aws_region.current.name}:${var.management_account_id}:key/${aws_kms_key.ct_kms_key.key_id}",
        Condition = {
          StringEquals = {
            "aws:SourceArn" = "arn:aws:cloudtrail:${data.aws_region.current.name}:${var.management_account_id}:trail/aws-controltower-BaselineCloudTrail"
          },
          StringLike = {
            "kms:EncryptionContext:aws:cloudtrail:arn" = "arn:aws:cloudtrail:*:${var.management_account_id}:trail/*"
          }
        }
      }
    ]
  })
}

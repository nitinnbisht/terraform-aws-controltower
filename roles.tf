# Role: AWSControlTowerAdmin
resource "aws_iam_role" "ct_admin" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "controltower.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy" "ct_admin_policy" {
  role = aws_iam_role.ct_admin.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "ec2:DescribeAvailabilityZones",
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ct_admin_managed_policy" {
  role       = aws_iam_role.ct_admin.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
}

# Role: AWSControlTowerStackSetRole
resource "aws_iam_role" "ct_stack_set_role" {
  name = "AWSControlTowerStackSetRole"
  path = "/service-role/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "cloudformation.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy" "ct_stack_set_role_policy" {
  role = aws_iam_role.ct_stack_set_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "sts:AssumeRole",
      Resource = "arn:aws:iam::*:role/AWSControlTowerExecution"
    }]
  })
}

# Role: AWSControlTowerCloudTrailRole
resource "aws_iam_role" "ct_cloudtrail_role" {
  name = "AWSControlTowerCloudTrailRole"
  path = "/service-role/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy" "ct_cloudtrail_role_policy" {
  role = aws_iam_role.ct_cloudtrail_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "logs:CreateLogStream",
        Resource = "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*"
      },
      {
        Effect   = "Allow",
        Action   = "logs:PutLogEvents",
        Resource = "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*"
      }
    ]
  })
}

# Role: AWSControlTowerConfigAggregatorRoleForOrganizations
resource "aws_iam_role" "ct_config_aggregator_role_for_organizations" {
  name = "AWSControlTowerConfigAggregatorRoleForOrganizations"
  path = "/service-role/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "config.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ct_config_aggregator_role_policy" {
  role       = aws_iam_role.ct_config_aggregator_role_for_organizations.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

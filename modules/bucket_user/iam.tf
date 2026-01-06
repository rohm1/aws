locals {
  allowed_ips_condition = {
    Condition = {
      IpAddress = {
        "aws:SourceIp" = var.allowed_ips
      }
    }
  }

  iam_policy_doc = merge(
    {
      Version = "2012-10-17"
      Statement = [
        merge(
          {
            "Sid" : "AllowListMyBuckets",
            "Action" : [
              "s3:ListAllMyBuckets"
            ],
            "Effect" : "Allow",
            "Resource" : [
              "arn:aws:s3:::*"
            ]
          },
          local.allowed_ips_condition
        ),
        merge(
          {
            Sid    = "AllowS3AccessToBucket"
            Effect = "Allow"
            Action = [
              "s3:ListBucket"
            ]
            Resource = [var.bucket_arn]
          },
          local.allowed_ips_condition
        ),
        merge(
          {
            Sid    = "AllowObjectActions"
            Effect = "Allow"
            Action = var.rw ? [
              "s3:GetObject",
              "s3:PutObject",
              "s3:DeleteObject"
              ] : [
              "s3:GetObject",
            ]
            Resource = ["${var.bucket_arn}/*"]
          },
          local.allowed_ips_condition
        )
      ]
    }
  )
}

resource "random_string" "name_suffix" {
  length  = 16
  upper   = false
  special = false
}

resource "aws_iam_user" "this" {
  name = "${var.name_prefix}-${var.rw ? "rw" : "ro"}-${random_string.name_suffix.result}"
}

resource "aws_iam_user_policy" "this" {
  user   = aws_iam_user.this.name
  policy = jsonencode(local.iam_policy_doc)
}

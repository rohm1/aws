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
            "Sid" : "AllowGroupToSeeBucketListInTheConsole",
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
            Resource = [aws_s3_bucket.this.arn]
          },
          local.allowed_ips_condition
        ),
        merge(
          {
            Sid    = "AllowObjectActions"
            Effect = "Allow"
            Action = [
              "s3:GetObject",
              "s3:PutObject",
              "s3:DeleteObject"
            ]
            Resource = ["${aws_s3_bucket.this.arn}/*"]
          },
          local.allowed_ips_condition
        )
      ]
    }
  )
}

resource "aws_iam_user" "this" {
  name = "bucket-user-${aws_s3_bucket.this.id}"
}

resource "aws_iam_user_policy" "this" {
  user   = aws_iam_user.this.name
  policy = jsonencode(local.iam_policy_doc)
}

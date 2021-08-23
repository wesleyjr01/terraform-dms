#create s3 role for target endpoint
resource "aws_iam_role" "dms_s3_role" {
  name = "${var.environment}-dms-s3-raw-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "dms.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"]

  inline_policy {
    name = "allow-s3-raw-dms"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:PutObject",
            "s3:DeleteObject",
            "s3:PutObjectTagging"
          ]
          Effect = "Allow"
          Resource = [
            "${var.raw_bucket_arn}*",
          ]
        },
        {
          Action = [
            "s3:ListBucket"
          ]
          Effect = "Allow"
          Resource = [
            "*",
          ]
        },
      ]
    })
  }

  tags = {
    description = "Role to allow DMS Target endpoint to acess s3 raw bucket."
  }
}

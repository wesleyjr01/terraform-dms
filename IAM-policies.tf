data "aws_iam_policy_document" "assume_glue_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role_glue_crawler_raw" {
  name               = "role_glue_crawler_raw"
  assume_role_policy = data.aws_iam_policy_document.assume_glue_policy.json # (not shown)

  inline_policy {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:GetObject",
            "s3:PutObject"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

  inline_policy {
    name   = "assume_glue_policy"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
data "aws_iam_policy_document" "assume_glue_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "AWSGlueServiceRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "glue-role-policy-attach" {
  role       = aws_iam_role.role_glue_crawler_raw.name
  policy_arn = data.aws_iam_policy.AWSGlueServiceRole.arn
}

resource "aws_iam_role" "role_glue_crawler_raw" {
  name               = "role_glue_crawler_raw"
  assume_role_policy = data.aws_iam_policy_document.assume_glue_policy.json

  inline_policy {
    name = "acess_s3_bucket_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:GetObject",
            "s3:PutObject"
          ]
          Effect   = "Allow"
          Resource = "${aws_s3_bucket.raw_bucket.arn}*"
        },
      ]
    })
  }
}

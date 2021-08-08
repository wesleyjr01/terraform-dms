resource "aws_iam_role" "glue_crawlers_raw" {
  name               = "glue_crawlers_raw_policy"
  assume_role_policy = "AWSGlueServiceRole"

  inline_policy {
    name = "allow_s3_get_put_cation"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject",
            "s3:PutObject"
          ],
          "Resource" : [
            "*"
          ]
        },
      ]
    })
  }
}

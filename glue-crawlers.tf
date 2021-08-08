resource "aws_glue_crawler" "crawler_raw_bucket" {
  database_name = "raw_database1"
  schedule      = "cron(0 1 * * * *)"
  name          = "events_crawler_raw_bucket_${var.environment}"
  role          = aws_iam_role.role_glue_crawler_raw.arn
  tags = {
    Context     = "Crawl all data from raw_bucket"
    Environment = var.environment
  }

  configuration = jsonencode(
    {
      Grouping = {
        TableGroupingPolicy = "CombineCompatibleSchemas"
      }
      CrawlerOutput = {
        # partitions inherit metadata properties from their parent table
        Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
        # New columns are added as they are encountered, including nested data types. But existing columns are not removed
        Tables = { AddOrUpdateBehavior = "MergeNewColumns" }
      }
      Version = 1
    }
  )

  s3_target {
    path = "s3://${var.raw_bucket_name}"
  }
}

resource "aws_glue_crawler" "crawler_raw_bucket" {
  database_name = "raw_database1"
  schedule      = "cron(0 1 * * ? *)"
  name          = "events_crawler_raw_bucket_${var.environment}"
  role          = "arn:aws:iam::657613168245:role/service-role/AWSGlueServiceRole-ReadFromBucket"
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
    path = "s3://${aws_s3_bucket.raw_bucket.bucket}"
  }
}

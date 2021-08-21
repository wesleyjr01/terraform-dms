# Create a new endpoint
resource "aws_dms_endpoint" "source_postgres" {
  database_name = "test_db"
  endpoint_id   = "${var.environment}-postgres-source"
  endpoint_type = "source"
  engine_name   = "postgres"
  port          = jsondecode(var.source_secrets_string)["port"]
  server_name   = jsondecode(var.source_secrets_string)["host"]
  username      = jsondecode(var.source_secrets_string)["username"]
  password      = jsondecode(var.source_secrets_string)["password"]
  ssl_mode      = "none"

  tags = {
    dbInstanceIdentifier = jsondecode(var.source_secrets_string)["dbInstanceIdentifier"]
  }
}

resource "aws_dms_endpoint" "target_s3_raw_bucket" {
  endpoint_id                 = "${var.environment}-s3-raw-target"
  endpoint_type               = "target"
  engine_name                 = "s3"
  extra_connection_attributes = "bucketFolder=postgres-db;dataFormat=parquet;addColumnName=true;timestampColumnName=dms_load_timestamp;cdcMinFileSize=100;cdcMaxBatchInterval=180;cdcInsertsAndUpdates=true;includeOpForFullLoad=True"
  s3_settings {
    # bucket_folder           = "postgres-db"
    bucket_name             = var.raw_bucket_name
    service_access_role_arn = aws_iam_role.dms_s3_role.arn
  }

  tags = {
    targetBucket = var.raw_bucket_name
  }
}

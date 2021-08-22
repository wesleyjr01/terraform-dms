# Create a new replication task
resource "aws_dms_replication_task" "postgres_to_s3_ongoing_replication_task" {
  replication_task_id      = "${var.environment}-postgres-to-s3-ongoing"
  migration_type           = "full-load-and-cdc"
  replication_instance_arn = aws_dms_replication_instance.replication_instance_t2small.replication_instance_arn
  source_endpoint_arn      = aws_dms_endpoint.source_postgres.endpoint_arn
  target_endpoint_arn      = aws_dms_endpoint.target_s3_raw_bucket.endpoint_arn

  replication_task_settings = trimspace(file("${path.module}/replication_task_settings.json"))

  table_mappings = trimspace(file("${path.module}/table_mappings.json"))

  tags = {
    context = "Load data from source postgres to raw s3 bucket."
  }
}

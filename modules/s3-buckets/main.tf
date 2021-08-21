resource "aws_s3_bucket" "raw_bucket" {
  bucket = "raw-bucket-${var.environment}-011234"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "Data Lake raw bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "raw_bucket" {
  bucket = "raw-bucket-${environment}-01123"
  acl    = "private"
  versioning {
    enabled = false
  }

  tags = {
    Name        = "Data Lake raw bucket"
    Environment = var.environment
  }

}

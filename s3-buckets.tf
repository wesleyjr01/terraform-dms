resource "aws_s3_bucket" "raw_bucket" {
  bucket = var.raw_bucket_name
  acl    = "private"
  versioning {
    enabled = false
  }

  tags = {
    Name        = "Data Lake raw bucket"
    Environment = var.environment
  }

}

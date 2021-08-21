output "raw_bucket_name" {
  value = aws_s3_bucket.raw_bucket.bucket
}

output "raw_bucket_arn" {
  value = aws_s3_bucket.raw_bucket.arn
}

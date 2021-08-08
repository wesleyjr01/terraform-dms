variable "instance_name" {
  description = "Value of the Name tag for EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "instance_type" {
  description = "EC@ instance type"
  type        = string
  default     = "t2.small"
}

variable "aws_region" {
  default = "us-west-2"
}


variable "environment" {
  default = "production"
}

variable "raw_bucket_name" {
  default = "raw-bucket-${var.environment}-01123"
}

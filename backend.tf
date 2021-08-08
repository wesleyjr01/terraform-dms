terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "s3" {
    bucket = "terraform-0123"
    key    = "artifacts/"
    region = "us-west-2"
  }
}

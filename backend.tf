terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "s3" {
    bucket = "terraform-test-state1"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}

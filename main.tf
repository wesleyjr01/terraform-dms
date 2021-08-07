
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
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0747bdcabd34c712a"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

provider "aws" {
  region = var.aws_region
  # access_key = ""
  # secret_key = ""
}

module "s3_buckets" {
  source = "./modules/s3-buckets"

  environment = var.environment
}

module "secrets_manager" {
  source = "./modules/secrets-manager"
}

module "dms" {
  source = "./modules/dms"

  aws_region       = var.aws_region
  environment      = var.environment
  subnet_group_ids = var.subnet_group_ids
  security_group   = var.security_group
}

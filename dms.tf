# Database Migration Service requires the below IAM Roles to be created before
# replication instances can be created. See the DMS Documentation for
# additional information: https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.APIRole
#  * dms-vpc-role
#  * dms-cloudwatch-logs-role
#  * dms-access-for-endpoint


resource "aws_iam_role" "dms_access_for_endpoint" {
  name = "dms-access-for-endpoint"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "dms.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonDMSRedshiftS3Role"]
}


resource "aws_iam_role" "dms_cloudwatch_logs_role" {
  name = "dms-cloudwatch-logs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "dms.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"]
}


resource "aws_iam_role" "dms_vpc_role" {
  name = "dms-vpc-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "dms.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"]
}

# # Create a new replication instance
# resource "aws_dms_replication_instance" "replication_instance_t2small" {
#   allocated_storage           = 20
#   apply_immediately           = true
#   auto_minor_version_upgrade  = true
#   availability_zone           = "${var.aws_region}a"
#   engine_version              = "3.4.4"
#   multi_az                    = false
#   publicly_accessible         = false
#   replication_instance_class  = "dms.t2.small"
#   replication_instance_id     = "dms-replication-instance-t2small-${var.environment}"
#   replication_subnet_group_id = aws_dms_replication_subnet_group.subnet_groups.replication_subnet_group_id

#   tags = {
#     Name = "Replication instance t2 small. At first we will only migrate from postgres to s3"
#   }

#   vpc_security_group_ids = [
#     var.security_group
#   ]
# }

# Create a new replication subnet group
resource "aws_dms_replication_subnet_group" "subnet_groups" {
  replication_subnet_group_description = "replication subnet group"
  replication_subnet_group_id          = "${var.environment}-dms-replication-subnet-group"

  subnet_ids = tolist(var.subnet_group_ids)

  tags = {
    Name = "${var.environment}-dms-replication-subnet-group"
  }
}

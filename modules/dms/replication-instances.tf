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

output "source_db_user" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.postgres_db_info.secret_string)["username"]
  sensitive = true
}

output "source_db_engine" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.postgres_db_info.secret_string)["engine"]
  sensitive = true
}

output "source_db_host" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.postgres_db_info.secret_string)["host"]
  sensitive = true
}

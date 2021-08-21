
output "source_postgres_secret_string" {
  value = data.aws_secretsmanager_secret_version.postgres_db_info.secret_string
}

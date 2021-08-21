output "source_db_user" {
  value     = jsondecode(module.secrets_manager.source_postgres_secret_string)["username"]
  sensitive = true
}

output "source_db_engine" {
  value     = jsondecode(module.secrets_manager.source_postgres_secret_string)["engine"]
  sensitive = true
}

output "source_db_host" {
  value     = jsondecode(module.secrets_manager.source_postgres_secret_string)["host"]
  sensitive = true
}

############# SOURCE POSTGRES DB SECRETS #############
data "aws_secretsmanager_secret" "postgres_secret_name" {
  name = "postgresdb/rds/user"
}

data "aws_secretsmanager_secret_version" "postgres_db_info" {
  secret_id = data.aws_secretsmanager_secret.postgres_secret_name.id
}
############# SOURCE POSTGRES DB SECRETS #############

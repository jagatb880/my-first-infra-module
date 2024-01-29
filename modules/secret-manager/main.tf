provider "aws" {
  region = "us-east-1"
}

resource "aws_secretsmanager_secret" "my-secret" {
  name = "my-secret"
}

resource "aws_secretsmanager_secret_version" "my_secret_version" {
  secret_id = aws_secretsmanager_secret.my-secret.id

  secret_string = <<EOF
{
  "db_name": "${var.environment_name}_mydb",
  "username": "admin",
  "password": "#admin2024"
}
EOF
}

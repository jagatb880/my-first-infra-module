# resource "aws_db_instances" "database" {
#   engine            = var.rds_engine
#   engine_version    = var.rds_engine_version
#   allocated_storage = var.rds_storage_gb
#   username          = "admin"
#   password          = "admin"
# }

provider "aws" {
  region = "us-east-1"
}
resource "aws_db_instance" "database" {
  allocated_storage = var.rds_storage_gb
  db_name           = "${var.environment_name}_mydb"
  engine            = var.rds_engine
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  username          = "admin"
  password          = "#admin2024"
  # db_subnet_group_name = "${var.environment_name}-db-subnet-group"

}

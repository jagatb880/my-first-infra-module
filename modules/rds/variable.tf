variable "rds_engine" {
  default = "mysql"
}

variable "rds_engine_version" {
  default = "5.7"

}

variable "rds_storage_gb" {
  default = "10"
}

variable "environment_name" {
  type    = string
  default = "default"
}

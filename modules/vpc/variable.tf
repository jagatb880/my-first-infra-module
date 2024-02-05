# variable "environment_name" {
#   default = "dev"
# }

# variable "environment_name" {
#   type    = list(string)
#   default = ["dev", "qa", "prod"]
# }

variable "environment_name" {
  type    = string
  default = "default"
}

variable "internet_gatewa_id" {
  type    = string
  default = "default"
}

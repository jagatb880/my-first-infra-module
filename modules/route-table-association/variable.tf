variable "environment_name" {
  type    = string
  default = "default"
}

variable "subnet_id" {
  description = "The ID of the VPC to associate with the Route 53 hosted zone"
  type        = string
}

variable "route_table" {
  description = "The ID of the VPC to associate with the Route 53 hosted zone"
  type        = string
}

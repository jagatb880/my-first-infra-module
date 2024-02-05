variable "environment_name" {
  type    = string
  default = "default"
}

variable "vpc_id" {
  description = "The ID of the VPC to associate with the Route 53 hosted zone"
  type        = string
}

variable "internet_gatewa_id" {
  description = "The ID of the VPC to associate with the Route 53 hosted zone"
  type        = string
}

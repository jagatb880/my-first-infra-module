variable "environment_name" {
  type    = string
  default = "default"
}

# Define a variable for the VPC ID to associate with the Route 53 hosted zone
variable "vpc_id" {
  description = "The ID of the VPC to associate with the Route 53 hosted zone"
  type        = string
}

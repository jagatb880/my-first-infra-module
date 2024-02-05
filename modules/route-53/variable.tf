# Define a variable for the Route 53 hosted zone domain name
variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
}

# Define a variable for the VPC ID to associate with the Route 53 hosted zone
variable "vpc_id" {
  description = "The ID of the VPC to associate with the Route 53 hosted zone"
  type        = string
}

# Define a variable for the environment name
variable "environment_name" {
  description = "The name of the environment"
  type        = string
  default     = "default"
}

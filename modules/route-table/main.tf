provider "aws" {
  region = "us-east-1"
}
# variable "vpc_id" {
#   description = "VPC ID from the VPC module"
# }

# Use the output from the VPC module as an input
# module "vpc" {
#   source           = "./modules/vpc"
#   environment_name = var.environment_name
# }


# variable "internet_gatewa_id" {
#   description = "IG ID from the Internet Gatway module"
# }

resource "aws_route_table" "example" {
  # vpc_id = var.vpc_id
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gatewa_id
  }

  tags = {
    Name = "${var.environment_name}_example"
  }
}

output "id" {
  value = aws_route_table.example.id
}

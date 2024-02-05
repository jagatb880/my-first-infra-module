//to do connection between subnet and route-table
provider "aws" {
  region = "us-east-1"
}
# variable "vpc_id" {
#   description = "VPC ID from the VPC module"
# }

# variable "route_table" {
#   description = "IG ID from the Internet Gatway module"
# }
resource "aws_route_table_association" "rt_custom_internet_association" {
  subnet_id      = var.subnet_id
  route_table_id = var.route_table
}

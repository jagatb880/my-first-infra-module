variable "vpc_id" {
  description = "VPC ID from the VPC module"
}
resource "aws_internet_gateway" "ig_custom" {
  vpc_id = var.vpc_id

  tags = {
    "Name" = "${var.environment_name}_ig_custom"
  }
}
output "ig_id" {
  value = aws_internet_gateway.ig_custom.id
}

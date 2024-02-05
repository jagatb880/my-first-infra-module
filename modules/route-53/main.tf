provider "aws" {
  region = "us-east-1"
}

# Create a Route 53 hosted zone
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

# Associate the Route 53 hosted zone with the specified VPC
resource "aws_route53_vpc_association_authorization" "main" {
  vpc_id  = var.vpc_id
  zone_id = aws_route53_zone.main.id
}

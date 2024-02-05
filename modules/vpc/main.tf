provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "customer_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    "Name" = "${var.environment_name}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.customer_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "10.0.2.0 - us-east-1a"
  }
}

resource "aws_security_group" "sg_custom" {
  vpc_id = aws_vpc.customer_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"        = "${var.environment_name}_sg_custom"
    "Description" = "${var.environment_name}_sg_custom"
  }
}

output "vpc_id" {
  value = aws_vpc.customer_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

# resource "aws_internet_gateway" "ig_custom" {
#   vpc_id = aws_vpc.customer_vpc.id

#   tags = {
#     "Name" = "${var.environment_name}_ig_custom"
#   }
# }

# resource "aws_route_table" "example" {
#   vpc_id = aws_vpc.customer_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = var.internet_gatewa_id
#   }

#   tags = {
#     Name = "${var.environment_name}_example"
#   }
# }

# resource "aws_route_table_association" "rt_custom_internet_association" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.example.id
# }

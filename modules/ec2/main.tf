provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2-control" {
  ami           = "ami-0a3c3a20c09d6f377"
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    "Name"        = "web_server_${var.environment_name}"
    "Environment" = var.environment_name
  }
}

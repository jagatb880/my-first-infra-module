provider "aws" {
  region = "us-east-1"
}

resource "aws_api_gateway_rest_api" "my_api" {
  name = "my-api"
}

resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "myresource"
}

resource "aws_api_gateway_method" "my_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

output "api_gateway_arn" {
  value = aws_api_gateway_rest_api.my_api.execution_arn
}

// Define more resources and methods as needed

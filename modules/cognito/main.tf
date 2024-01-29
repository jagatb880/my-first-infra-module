provider "aws" {
  region = "us-east-1"
}
resource "aws_cognito_user_pool" "users" {
  name = "${var.environment_name}-users"
  # ... Other Cognito user pool configurations
}

resource "aws_cognito_identity_pool" "identities" {
  identity_pool_name               = "${var.environment_name}-identities"
  allow_unauthenticated_identities = false
}

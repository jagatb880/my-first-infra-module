module "iam" {
  source           = "../../modules/iam"
  environment_name = terraform.workspace
}

module "cognito" {
  source           = "../../modules/cognito"
  environment_name = terraform.workspace
}

module "rds" {
  source           = "../../modules/rds"
  environment_name = terraform.workspace
}
module "vpc" {
  source           = "../../modules/vpc"
  environment_name = terraform.workspace
}
module "s3" {
  source           = "../../modules/s3"
  environment_name = terraform.workspace
}
module "ec2" {
  source           = "../../modules/ec2"
  environment_name = terraform.workspace
}
# module "cloudfront" {
#   source           = "../../modules/cloudfront"
#   environment_name = terraform.workspace
#   s3_bucket_name   = module.s3.s3_bucket_name
# }
# module "internet_gateway" {
#   source           = "../../modules/internet-gateway"
#   environment_name = terraform.workspace
#   vpc_id           = module.vpc.vpc_id
# }
# module "route_table" {
#   source             = "../../modules/route-table"
#   environment_name   = terraform.workspace
#   vpc_id             = module.vpc.vpc_id
#   internet_gatewa_id = module.internet_gateway.ig_id
# }


# terraform {
#   backend "s3" {
#     bucket = "dev-shared-data"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#   }
# }

module "iam" {
  source           = "../../modules/iam"
  environment_name = terraform.workspace
}
# module "secret-manager" {
#   source           = "../../modules/secret-manager"
#   environment_name = terraform.workspace
# }
# module "cognito" {
#   source           = "../../modules/cognito"
#   environment_name = terraform.workspace
# }

# module "rds" {
#   source           = "../../modules/rds"
#   environment_name = terraform.workspace
# }
module "vpc" {
  source             = "../../modules/vpc"
  environment_name   = terraform.workspace
  internet_gatewa_id = module.internet_gateway.ig_id
}
module "route-53" {
  source           = "../../modules/route-53"
  environment_name = terraform.workspace
  vpc_id           = module.vpc.vpc_id
  domain_name      = "www.robosoftin.com"
}
module "s3" {
  source           = "../../modules/s3"
  environment_name = terraform.workspace
}
module "ec2" {
  source           = "../../modules/ec2"
  environment_name = terraform.workspace
}
module "cloudfront" {
  source           = "../../modules/cloudfront"
  environment_name = terraform.workspace
  s3_bucket_domain = module.s3.s3_bucket_domain
}
module "internet_gateway" {
  source           = "../../modules/internet-gateway"
  environment_name = terraform.workspace
  vpc_id           = module.vpc.vpc_id
}
module "route-table" {
  source             = "../../modules/route-table"
  environment_name   = terraform.workspace
  vpc_id             = module.vpc.vpc_id
  internet_gatewa_id = module.internet_gateway.ig_id
}

module "route-table-association" {
  source           = "../../modules/route-table-association"
  environment_name = terraform.workspace
  subnet_id        = module.vpc.subnet_id
  route_table      = module.route-table.id
}

//to do connection between subnet and route-table
# module "vpc" {
#   source           = "../vpc"
#   environment_name = var.environment_name
# }

# module "route_table" {
#   source           = "../route-table"
#   environment_name = var.environment_name
# }
# resource "aws_route_table_association" "rt_custom_internet_association" {
#   subnet_id      = module.vpc.id
#   route_table_id = module.route_table.id
# }

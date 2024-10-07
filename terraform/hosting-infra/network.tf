module "basic_infra" {
  source = "../modules/network-basic-infra"

  vpc_name = var.vpc_name
}
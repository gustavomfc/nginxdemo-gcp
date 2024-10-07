module "k8s-cluster" {
  source = "../modules/k8s-cluster"

  vpc_name                       = var.vpc_name
  nodes_sa_name                  = var.nodes_sa_name
  nodes_sa_display_name          = var.nodes_sa_display_name
  cluster_name                   = var.cluster_name
  cluster_region                 = var.cluster_region
  cluster_subnet_name            = var.cluster_subnet_name
  vpc_id                         = module.basic_infra.vpc_id
  cluster_subnet_primary_ip_cidr = var.cluster_subnet_primary_ip_cidr
  cluster_subnet_pods_ip_cidr    = var.cluster_subnet_pods_ip_cidr

  depends_on = [
    # The basic network infrastructure needs to be up before the cluster can be created
    module.basic_infra
  ]
}
module "bastion_proxy" {
  source = "../modules/bastion-host"

  bastion_sa_name        = var.bastion_sa_name
  bastion_vm_name        = var.bastion_vm_name
  bastion_vm_zone        = var.bastion_vm_zone
  bastion_subnet_name    = var.bastion_subnet_name
  bastion_subnet_ip_cidr = var.bastion_subnet_ip_cidr
  bastion_region         = var.cluster_region
  vpc_id                 = module.basic_infra.vpc_id

  depends_on = [
    module.basic_infra
  ]
}

output "bastion_connection_command" {
  value       = module.bastion_proxy.iap_tunnel_command
  description = "Command to connect to create the tunnel to the bastion host and set the HTTPS Proxy environ to the created tunnel"
} 
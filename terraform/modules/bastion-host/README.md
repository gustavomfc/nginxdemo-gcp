# GKE Bastion Host

This module intends to create a Bastion host to be used as a Proxy using IAP tunnel in order to make possible to manage the GKE Private Cluster

### Minimum providers versions required:

- hashicorp/google - 6.5.0

## Resources Created

- Service Account used by the Bastion
- Subnet used by Bastion VM
- Bastion VM

## Module Inputs

- ```bastion_sa_name``` - The name of the service account to create for the bastion host
- ```bastion_sa_display_name``` - The display name of the service account to create for the bastion host. | Optional: If this is not set, the value of bastion_sa_name will be used
- ```bastion_vm_name``` - The name of the bastion host VM
- ```bastion_vm_type``` - The machine type of the bastion host VM. Default: t2d-standard-2
- ```bastion_vm_zone``` - The zone where the bastion host VM will be created
- ```bastion_os_image``` - The OS image for the bastion host VM. Default: ubuntu-os-cloud/ubuntu-2004-lts
- ```bastion_subnet_name``` - The name of the subnet that will be created to host the bastion VM
- ```bastion_subnet_ip_cidr``` - The IP CIDR range for the bastion subnet. A /29 CIDR is recommended
- ```bastion_region``` - The region where the bastion host will be created
- ```vpc_id``` - The ID of the VPC where the bastion host will be created

## Module Outputs

The module provide the following outputs:

- ```iap_tunnel_command``` - The gcloud command that should be used to activate the IAP Tunnel properly to use the Bastion as a HTTPS Proxy to connect to the KubeAPI Server

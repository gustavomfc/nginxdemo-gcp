# GKE Cluster

This module intends to create a GKE Autopilot cluster

### Minimum providers versions required:

- hashicorp/google - 6.5.0

## Resources Created

- Service Account used by the GKE Nodes
- Subnet with the secondary IP ranges required by GKE (Pods and Services)
- GKE Cluster

## Module Inputs

- ```vpc_name``` - The name of the VPC where the resources will be created
- ```vpc_id``` - The ID of the VPC where the resources will be created
- ```nodes_sa_name``` - The name of the Service Account that will be used by the nodes
- ```nodes_sa_display_name``` - The Display Name of the Service Account that will be used by the nodes | OPTIONAL VALUE: If this value is not inputed, the ```nodes_sa_name``` value will be used as the SA Display Name
- ```cluster_name``` - The name of the cluster that will be created
- ```cluster_region``` - The region where the cluster will be created
- ```cluster_subnet_name``` - The name of the subnet that will be crated to be used by the cluster
- ```cluster_subnet_primary_ip_cidr``` - The primary CIDR of the subnet that will be created. This range is for the nodes usage
- ```cluster_subnet_services_ip_cidr``` - The CIDR range for services in the cluster subnet | Optional: As this CIDR can be overlapped by other clusters, the default CIDR to services is 10.254.0.0/20
- ```cluster_subnet_pods_ip_cidr``` - The CIDR that will be allocated to pods usage

## Module Outputs

The module provide the following outputs:


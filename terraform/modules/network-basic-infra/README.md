# GCP Basic Network Infrastructure

This module intends to create the basic infra needed to host services that uses servers, properly in the cloud.

### Minimum providers versions required:

- hashicorp/google - 6.5.0

## Services Created

- VPC
- Cloud Router
- Cloud NAT
- Global Proxy Only Subnet
- IAP Ingress firewall rule
- Web egress firewall rule

## Module Inputs

- ```supported_regions``` - A list of the regions where the regional resources (Cloud Nat and Cloud Router) should be created. By default this list is composed only by ```us-east1``` region.
- ```project_id``` - The Project ID of the project where the resources need to be created. By default this value is inherited from the root's provider setting.
- ```vpc_name``` - The desired name of the VPC
- ```auto_create_subnetworks``` - Whether to create subnetworks automatically. By default this is set to ```False```. (https://cloud.google.com/vpc/docs/create-modify-vpc-networks#create-auto-network)
- ```routing_mode``` - The VPC routing mode. By default this is set to ```GLOBAL```. 
- ```router_name_prefix``` - The prefix that will be used to name the Routers created. By default this prefix will be: ```<vpc-name>-router```
- global_proxy_only_subnet_ip_cidr - The IP CIDR to be used by the Global Proxy Only Subnet. If not set, it will defaults to ```100.64.0.0/24``` (A non RFC-1918 CIDR, but it's private, as this range is reserved to be used by carriers in CGNAT, which means it's not routed in the public networks)

## Module Outputs

The module provide the following outputs:

- ```vpc_id``` - The ID of the created VPC
- ```routers_names``` - The created Cloud Routers names
- ```routers_ids``` - The created Cloud Routers IDs
- ```nat_names```- The created Cloud NATs names
- ```nat_ids```- The created Cloud NATs IDs
variable "vpc_name" {
  type        = string
  description = "The name of the VPC that will be created"
}

variable "nodes_sa_name" {
  type        = string
  description = "The name of the service account that will be used by nodes"
}

variable "nodes_sa_display_name" {
  type        = string
  description = "The display name of the service account that will be used by nodes. | Optional: If this is not set, the value of nodes_sa_name will be used"
  default     = ""
}

variable "cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
}

variable "cluster_region" {
  type        = string
  description = "The location of the GKE cluster"
}

variable "cluster_subnet_name" {
  type        = string
  description = "The name of the cluster subnet"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the cluster subnet will be created"
}

variable "cluster_subnet_primary_ip_cidr" {
  type        = string
  description = "The primary IP CIDR range of the cluster subnet"
}

variable "cluster_subnet_services_ip_cidr" {
  type        = string
  description = "The IP CIDR range for services in the cluster subnet | Optional: As this CIDR can be overlapped by other clusters, the default CIDR to services is 10.254.0.0/20"
  default     = "10.254.0.0/20"
}

variable "cluster_subnet_pods_ip_cidr" {
  type        = string
  description = "The IP CIDR range for pods in the cluster subnet"
}

variable "cluster_controller_ipv4_cidr_block" {
  type        = string
  description = "The IP CIDR range for the master in the cluster subnet"
}
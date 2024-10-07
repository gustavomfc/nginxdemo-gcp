variable "project_id" {
  type        = string
  description = "The project ID where the resources will be created"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC that will be created"
  default     = "codilime-task-1-vpc"
}

variable "nodes_sa_name" {
  type        = string
  description = "The name of the service account that will be used by nodes"
  default     = "gke-task1-nodes-sa"
}

variable "nodes_sa_display_name" {
  type        = string
  description = "The display name of the service account that will be used by nodes. | Optional: If this is not set, the value of nodes_sa_name will be used"
  default     = "SA Used by the hosting cluster of task1 app"
}

variable "cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
  default     = "task1-cluster"
}

variable "cluster_region" {
  type        = string
  description = "The location of the GKE cluster"
  default     = "us-east1"
}

variable "cluster_subnet_name" {
  type        = string
  description = "The name of the cluster subnet"
  default     = "task1-cluster-us-e1-subnet"
}

variable "cluster_controller_subnet_name" {
  type        = string
  description = "The name of the controller cluster subnet"
  default     = "task1-cluster-controller-us-e1-subnet"
}

variable "cluster_controller_ipv4_cidr_block" {
  type        = string
  description = "The IP CIDR range for the controller in the cluster subnet"
  default     = "10.200.0.0/28"
}

variable "cluster_subnet_primary_ip_cidr" {
  type        = string
  description = "The primary IP CIDR range of the cluster subnet"
  default     = "10.0.0.0/24"
}

variable "cluster_subnet_pods_ip_cidr" {
  type        = string
  description = "The IP CIDR range for pods in the cluster subnet"
  default     = "10.250.0.0/16"
}
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

variable "bastion_sa_name" {
  type        = string
  description = "The name of the service account to create for the bastion host"
  default     = "task1-bastion-sa"
}

variable "bastion_vm_name" {
  type        = string
  description = "The name of the bastion host VM"
  default     = "task1-bastion"
}

variable "bastion_vm_zone" {
  type        = string
  description = "The zone where the bastion host VM will be created"
  default     = "us-east1-b"
}

variable "bastion_subnet_name" {
  type        = string
  description = "The name of the subnet that will be created to host the bastion VM"
  default     = "task1-bastion-us-e1-subnet"
}

variable "bastion_subnet_ip_cidr" {
  type        = string
  description = "The IP CIDR range for the bastion subnet. A /29 CIDR is recommended"
  default     = "10.100.0.0/29"
}
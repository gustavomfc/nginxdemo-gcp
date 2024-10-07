variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "cluster_name" {
  type        = string
  description = "The GKE cluster name"
  default     = "task1-cluster"
}

variable "cluster_location" {
  type        = string
  description = "The GKE cluster location"
  default     = "us-east1"
}

variable "namespace" {
  type        = string
  description = "The namespace to deploy the application"
  default     = "task1-app"
}

variable "app_name" {
  type        = string
  description = "The name of the application"
  default     = "task1-app"
}

variable "app_image" {
  type        = string
  description = "The app image to be deployed | Defaults to: nginxdemos/hello/"
  default     = "nginxdemos/hello"
}

variable "replicas" {
  type        = number
  description = "The number of replicas to deploy | Defaults to: 3"
  default     = 3
}

variable "app_fqdn" {
  type        = string
  description = "The FQDN name of the application"
  default     = "task1-app.mendanhafranco.com"
}

variable "dns_zone_name" {
  type        = string
  description = "The managed DNS zone name"
  default     = "mendanhafranco-com"
}
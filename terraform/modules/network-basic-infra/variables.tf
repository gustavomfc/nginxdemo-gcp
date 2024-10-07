variable "supported_regions" {
  type = set(string)
  default = [
    "us-east1",
  ]
  description = "The list of regions where the resources can be created. Default: us-east1"
}

variable "project_id" {
  type        = string
  description = "The project ID where the resources will be created"
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC that will be created"
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "Whether to create subnetworks automatically. Default: false"
  default     = false
}

variable "routing_mode" {
  type        = string
  description = "The routing mode for the VPC | Possible values: REGIONAL, GLOBAL. Default: GLOBAL"
  default     = "GLOBAL"
}

variable "router_name_prefix" {
  type        = string
  description = "The prefix for the router name. Default: <vpc_name>-router"
  default     = ""
}

variable "global_proxy_only_subnet_ip_cidr" {
  type        = string
  description = "The IP CIDR range for the global proxy only subnet | Optional: If not set it will defautls to 100.64.0.0/24"
  default     = "100.64.0.0/24"
}
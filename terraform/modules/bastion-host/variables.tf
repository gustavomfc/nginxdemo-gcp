variable "bastion_sa_name" {
    description = "The name of the service account to create for the bastion host"
    type        = string
}

variable "bastion_sa_display_name" {
    description = "The display name of the service account to create for the bastion host. | Optional: If this is not set, the value of bastion_sa_name will be used"
    type        = string
    default = ""
}

variable "bastion_vm_name" {
    description = "The name of the bastion host VM"
    type        = string
}

variable "bastion_vm_type" {
    description = "The machine type of the bastion host VM. Default: t2d-standard-2"
    type        = string
    default = "t2d-standard-2"
}

variable "bastion_vm_zone" {
    description = "The zone where the bastion host VM will be created"
    type        = string
    default = ""
}

variable "bastion_os_image" {
    description = "The OS image for the bastion host VM. Default: ubuntu-os-cloud/ubuntu-2004-lts"
    type        = string
    default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "bastion_subnet_name" {
    description = "The name of the subnet that will be created to host the bastion VM"
    type        = string
}

variable "bastion_subnet_ip_cidr" {
    description = "The IP CIDR range for the bastion subnet. A /29 CIDR is recommended"
    type        = string
}

variable "bastion_region" {
    description = "The region where the bastion host will be created"
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC where the bastion host will be created"
    type        = string
}
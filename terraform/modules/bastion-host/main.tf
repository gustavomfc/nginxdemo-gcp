locals {
    bastion_sa_display_name = var.bastion_sa_display_name != "" ? var.bastion_sa_display_name : var.bastion_sa_name
}

resource "google_service_account" "bastion_sa" {
  account_id   = var.bastion_sa_name
  display_name = var.bastion_sa_display_name
}

resource "google_compute_subnetwork" "bastion_subnet" {
  name = var.bastion_subnet_name

  ip_cidr_range = var.bastion_subnet_ip_cidr
  region        = var.bastion_region

  network = var.vpc_id
}

resource "google_compute_instance" "bastion_vm" {
  name         = var.bastion_vm_name
  machine_type = var.bastion_vm_type
  zone         = var.bastion_vm_zone

  boot_disk {
    initialize_params {
      image = var.bastion_os_image
    }
  }

  scheduling {
    preemptible = true
    automatic_restart = false
    provisioning_model = "SPOT"
    instance_termination_action = "STOP"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.bastion_subnet.id
  }

  metadata_startup_script = "apt update && apt install -y tinyproxy"

  service_account {
    email  = google_service_account.bastion_sa.email
    scopes = ["cloud-platform"]
  }

  depends_on = [
    google_compute_subnetwork.bastion_subnet,
    google_service_account.bastion_sa,
  ]
}
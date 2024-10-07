locals {
  nodes_sa_display_name = var.nodes_sa_display_name != "" ? var.nodes_sa_display_name : var.nodes_sa_name
}

resource "google_service_account" "nodes_sa" {
  account_id   = var.nodes_sa_name
  display_name = local.nodes_sa_display_name
}

resource "google_compute_subnetwork" "cluster_subnet" {
  name = var.cluster_subnet_name

  ip_cidr_range = var.cluster_subnet_primary_ip_cidr
  region        = var.cluster_region

  network = var.vpc_id

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.cluster_subnet_services_ip_cidr
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = var.cluster_subnet_pods_ip_cidr
  }
}

resource "google_container_cluster" "cluster" {
  name                     = var.cluster_name
  location                 = var.cluster_region
  enable_autopilot         = true
  allow_net_admin          = true # GKE Autopilot requires this
  network                  = var.vpc_name
  subnetwork               = google_compute_subnetwork.cluster_subnet.id
  enable_l4_ilb_subsetting = true

  node_config {
    service_account = google_service_account.nodes_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]

    gvnic {
      enabled = true
    }

    reservation_affinity {
      consume_reservation_type = "NO_RESERVATION"
    }

    kubelet_config {
      cpu_cfs_quota = false
      insecure_kubelet_readonly_port_enabled = "TRUE" # Autopilot only accepts "True" in 6.5.0 provider version
      pod_pids_limit = 0 # Autopilot only accepts "True" in 6.5.0 provider version
    }
  }

  cluster_autoscaling {
    auto_provisioning_defaults {
      service_account = google_service_account.nodes_sa.email
      oauth_scopes = [
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/trace.append",
      ]
    }
  }

  ip_allocation_policy {
    services_secondary_range_name = google_compute_subnetwork.cluster_subnet.secondary_ip_range[0].range_name
    cluster_secondary_range_name  = google_compute_subnetwork.cluster_subnet.secondary_ip_range[1].range_name
  }

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = true
    master_ipv4_cidr_block = var.cluster_controller_ipv4_cidr_block
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/8"
    }
  }

  timeouts {
    create = "30m"
    update = "40m"
  }

  depends_on = [
    google_service_account.nodes_sa,
    google_compute_subnetwork.cluster_subnet,
  ]

  deletion_protection = false
}
locals {
  router_name_prefix = var.router_name_prefix != "" ? var.router_name_prefix : "${var.vpc_name}-router"
}


resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}

resource "google_compute_router" "router" {
  for_each = toset(var.supported_regions)

  project = var.project_id
  name    = "${local.router_name_prefix}-${each.value}"
  region  = each.value
  network = google_compute_network.vpc_network.id

  depends_on = [
    google_compute_network.vpc_network
  ]
}

resource "google_compute_router_nat" "nat" {
  for_each = google_compute_router.router

  project = var.project_id
  name    = "${local.router_name_prefix}-nat-${each.value.region}"

  router                             = each.value.name
  region                             = each.value.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  depends_on = [
    google_compute_router.router
  ]
}

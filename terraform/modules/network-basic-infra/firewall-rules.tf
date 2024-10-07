resource "google_compute_firewall" "ingress-allow-iap-connections" {
  name        = "fw-ingress-allow-iap-connections"
  network     = google_compute_network.vpc_network.name
  description = "Allow any connection from IAP"

  allow {
    protocol = "tcp"
  }

  source_ranges = [
    "35.235.240.0/20"
  ]

  depends_on = [
    google_compute_network.vpc_network
  ]
}

resource "google_compute_firewall" "egress-allow-web-traffic" {
  name        = "fw-egress-allow-web-traffic"
  network     = google_compute_network.vpc_network.name
  description = "Allow any web (HTTP and HTTPS) egress connection"
  direction   = "EGRESS"

  allow {
    protocol = "tcp"
    ports = [
      "80",
      "443"
    ]
  }

  destination_ranges = [
    "0.0.0.0/0"
  ]

  depends_on = [
    google_compute_network.vpc_network
  ]
}
resource "google_compute_global_address" "ext_ip_address" {
  name = "${var.app_name}-ext-ip"
}

resource "google_dns_record_set" "dns_record" {
  name = "${var.app_fqdn}."
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone_name
  rrdatas      = [google_compute_global_address.ext_ip_address.address]

  depends_on = [
    google_compute_global_address.ext_ip_address
  ]
}

resource "kubernetes_manifest" "ssl_cert" {
  manifest = {
    "apiVersion" = "networking.gke.io/v1"
    "kind"       = "ManagedCertificate"
    "metadata" = {
      "name"      = "app-tls-cert",
      "namespace" = var.namespace
    }
    "spec" = {
      "domains" = [
        var.app_fqdn
      ]
    }
  }

  depends_on = [
    google_compute_global_address.ext_ip_address,
    google_dns_record_set.dns_record
  ]
}

resource "kubernetes_manifest" "https_redirect" {
  manifest = {
    "apiVersion" = "networking.gke.io/v1beta1"
    "kind"       = "FrontendConfig"
    "metadata" = {
      "name"      = "${var.app_name}-fe-config",
      "namespace" = var.namespace,
    }
    "spec" = {
      "redirectToHttps" = {
        "enabled"          = true
        "responseCodeName" = "MOVED_PERMANENTLY"
      }
    }
  }
}

resource "kubernetes_manifest" "app_ingress" {
  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "Ingress"
    "metadata" = {
      "name"      = "${var.app_name}-ingress",
      "namespace" = var.namespace,
      "annotations" = {
        "kubernetes.io/ingress.global-static-ip-name" = google_compute_global_address.ext_ip_address.name,
        "networking.gke.io/managed-certificates"      = "app-tls-cert",
        "kubernetes.io/ingress.class"                 = "gce"
        "networking.gke.io/v1beta1.FrontendConfig"    = kubernetes_manifest.https_redirect.manifest.metadata.name
      }
    }
    "spec" = {
      "defaultBackend" = {
        "service" = {
          "name" = "${var.app_name}-svc",
          "port" = {
            "number" = 80
          }
        }
      }
    }
  }

  depends_on = [
    google_compute_global_address.ext_ip_address,
    google_dns_record_set.dns_record,
    kubernetes_manifest.ssl_cert,
    kubernetes_manifest.https_redirect
  ]
}
resource "kubernetes_network_policy" "deny_all" {
    metadata {
        name = "deny-all"
        namespace = kubernetes_namespace.app_namespace.metadata.0.name
    }
    
    spec {
        pod_selector {}
        policy_types = ["Ingress", "Egress"]
    }
}

resource "kubernetes_network_policy" "allow_ingress_from_gcp_hc" {
    metadata {
        name = "allow-ingress-from-gcp-hc"
        namespace = kubernetes_namespace.app_namespace.metadata.0.name
    }
    
    spec {
        pod_selector {
            match_labels = {
                app = var.app_name
            }
        }
        policy_types = ["Ingress"]

        ingress {
            from {
                ip_block {
                    cidr = "35.191.0.0/16"
                }
            }
        }

        ingress {
            from {
                ip_block {
                    cidr = "130.211.0.0/22"
                }
            }
        }
    }
}

resource "kubernetes_network_policy" "allow_egress_to_gcp_metadata" {
    metadata {
        name = "allow-egress-gcp-metadata"
        namespace = kubernetes_namespace.app_namespace.metadata.0.name
    }
    
    spec {
        pod_selector {
            match_labels = {
                app = var.app_name
            }
        }
        policy_types = ["Egress"]

        egress {
            to {
                ip_block {
                    cidr = "169.254.169.254/32"
                }
            }

            ports {
                protocol = "TCP"
                port = "988"
            }
        }
    }
}
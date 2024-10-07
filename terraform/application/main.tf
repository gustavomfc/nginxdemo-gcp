resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_service_account" "app_service_account" {
  metadata {
    name      = "${var.app_name}-sa"
    namespace = kubernetes_namespace.app_namespace.metadata.0.name
  }

  automount_service_account_token = false

  depends_on = [
    kubernetes_namespace.app_namespace
  ]
}

resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = "${var.app_name}-deployment"
    namespace = kubernetes_namespace.app_namespace.metadata.0.name
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        service_account_name            = kubernetes_service_account.app_service_account.metadata.0.name
        automount_service_account_token = false

        toleration {
          key      = "kubernetes.io/arch"
          operator = "Equal"
          value    = "amd64"
          effect   = "NoSchedule"
        }

        container {
          image = var.app_image
          name  = var.app_name
          port {
            container_port = 80
            name           = "http"
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = 80
            }
          }

          resources {
            limits = {
              cpu               = "0.5"
              memory            = "512Mi"
              ephemeral-storage = "1Gi"
            }
            requests = {
              cpu               = "0.25"
              memory            = "256Mi"
              ephemeral-storage = "1Gi"
            }
          }

          security_context {
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false
            run_as_non_root            = false

            capabilities {
              drop = ["NET_RAW"]
              add  = []
            }
          }
        }
        security_context {
          run_as_non_root = false
          seccomp_profile {
            type = "RuntimeDefault"
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_namespace.app_namespace,
    kubernetes_service_account.app_service_account
  ]
}

resource "kubernetes_service" "app_service" {
  metadata {
    name      = "${var.app_name}-svc"
    namespace = kubernetes_namespace.app_namespace.metadata.0.name
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      target_port = 80
      port        = 80
    }

    type = "NodePort"
  }

  depends_on = [
    kubernetes_deployment.app_deployment
  ]
}
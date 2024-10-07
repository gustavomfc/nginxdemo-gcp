terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.32.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 6.5.0"
    }
  }
}
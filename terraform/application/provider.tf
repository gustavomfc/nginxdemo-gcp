provider "google" {
  project = var.project_id
}

data "google_client_config" "gcp_token" {
}

data "google_container_cluster" "cluster_info" {
  name     = var.cluster_name
  location = var.cluster_location
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.cluster_info.endpoint}"
  token = data.google_client_config.gcp_token.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.cluster_info.master_auth[0].cluster_ca_certificate,
  )
}
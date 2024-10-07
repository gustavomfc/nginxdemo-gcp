resource "google_dns_managed_zone" "mendanhafranco-zone" {
  name        = "mendanhafranco-com"
  dns_name    = "mendanhafranco.com."
  description = "mendanhafranco.com DNS zone"

  visibility = "public"
}
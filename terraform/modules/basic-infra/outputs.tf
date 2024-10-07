output "routers_names" {
  value = values(google_compute_router.router).*.name
}

output "routers_ids" {
  value = values(google_compute_router.router).*.id
}

output "nat_names" {
  value = values(google_compute_router_nat.nat).*.name
}

output "nat_ids" {
  value = values(google_compute_router_nat.nat).*.id
}
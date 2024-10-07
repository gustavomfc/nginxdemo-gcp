output "iap_tunnel_command" {
  value       = <<EOF
    gcloud compute ssh ${var.bastion_vm_name} --tunnel-through-iap --zone=${var.bastion_vm_zone} --ssh-flag="-4 -L8888:localhost:8888 -N -q -f" && export HTTPS_PROXY=localhost:8888"
  EOF
  description = "Command line to create an SSH tunnel through IAP to the bastion host to access GKE API server"
  depends_on  = []
}

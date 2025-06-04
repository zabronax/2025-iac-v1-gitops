output "server" {
  description = "Server details"
  value       = hcloud_server.server
}

output "cloud_init" {
  value = local.cloud_init
}

locals {
  cloud_init = templatefile("${path.module}/cloud-init.yaml", {
    source_repository     = var.source_address
    source_branch         = var.source_branch
    compose_path          = var.compose_path
    source_sync_frequency = var.source_sync_frequency
  })
}

resource "hcloud_server" "server" {
  name        = "gitops-server"
  image       = "debian-11"
  server_type = "cx22"

  user_data = local.cloud_init

  ssh_keys = var.ssh_keys

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

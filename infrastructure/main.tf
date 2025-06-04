terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.50"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

variable "hcloud_token" {
  sensitive = true
}

resource "hcloud_ssh_key" "maintenance_key" {
  name       = "maintenance-key"
  public_key = file("${path.root}/maintenance-key.pub")
}

module "gitops_server" {
  source = "./gitops-server"

  source_address        = "https://github.com/zabronax/2025-iac-v1-gitops"
  source_branch         = "main"
  compose_path          = "manifests/compose.production.yaml"
  source_sync_frequency = "30s"

  server_sku = "cax21"

  ssh_keys = [
    hcloud_ssh_key.maintenance_key.id
  ]
}

output "server" {
  description = "Information about the server"
  value = {
    ipv4_address = module.gitops_server.server.ipv4_address
    ipv6_address = module.gitops_server.server.ipv6_address
  }
}

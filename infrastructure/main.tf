terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

variable "hcloud_token" {
  sensitive = true
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "maintenance_key" {
  name = "maintenance-key"
  public_key = file("${path.root}/maintenance-key.pub")
}

resource "hcloud_server" "server" {
  name        = "node1"
  image       = "debian-11"
  server_type = "cx22"

  ssh_keys = [
    hcloud_ssh_key.maintenance_key.id
  ]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

output "server" {
  description = "Information about the server" 
  value = hcloud_server.server
}

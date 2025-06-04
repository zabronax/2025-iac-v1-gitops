variable "source_address" {
  description = "The address of the source repository"
  type        = string
  sensitive   = false
}

variable "source_branch" {
  description = "Branch to use as reconciliation target"
  type        = string
  sensitive   = false
}

variable "compose_path" {
  description = "Path from the repository root to the compose file"
  type        = string
  sensitive   = false
}

variable "source_sync_frequency" {
  description = "How often to reconcile with the source"
  type        = string
  sensitive   = false
}

variable "server_sku" {
  description = "Stock Keeping Unit (SKU)/Server type to use"
  type        = string
  sensitive   = false
}

variable "ssh_keys" {
  description = "ID of SSH keys stored in Hetzner"
  type        = list(string)
  sensitive   = false
}

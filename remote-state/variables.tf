variable "rg_name" {
  type = string
}

variable "rg_loc" {
  type    = string
  default = "eastus2"
}

variable "sa_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Defines the tier to use for the Storage Account"
}

variable "replication_type" {
  type        = string
  default     = "GRS"
  description = "Defines the type of replication to use for this storage account."
}

variable "workspace_to_env_map" {
  type = "map"
  default = {
    sandbox    = "sandbox"
    staging    = "staging"
    production = "production"
  }
}

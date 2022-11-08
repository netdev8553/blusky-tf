### Module Variables
variable "container_group_name" {
  type = string
}

variable "is_private_ip" {
  type        = string
  description = "If set to true, create an azurerm_network_profile and add in container_group"
}

variable "dns_name" {
  type = string
}

variable "container_os" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "container_address_prefix" {
  type        = string
  description = "Network prefix for container subnet group when launching into a different subnet"
}

### Imported Variables
variable "region" {
  type = string
}

variable "rg_name" {
  type = string
}

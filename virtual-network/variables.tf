variable "network_name" {
  type = string
}

variable "network_address_space" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_count" {
  default = "2"
  type    = string
}

## Imported Variables
variable "region" {
  type = string
}

variable "rg_name" {
  type = string
}

### Module Variables
variable "lb_name" {
  type = string
}

variable "backend_address_pool_name" {
  type = string
}

variable "nat_protocol" {
  type = string
}

variable "nat_frontend_port" {
  type = number
}

variable "nat_backend_port" {
  type = number
}

### Imported Variables
variable "region" {
  type = string
}

variable "rg_name" {
  type = string
}

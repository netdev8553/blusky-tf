### Regular Variables
variable "nsg_name" {
  type = string
}

variable "admin_cidr_ingress" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_1_id" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

### Imported Variables
variable "region" {
  type = string
}

variable "rg_name" {
  type = string
}

### Module Variables
variable "mysql_server_name" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "storage_mb" {
  type = string
}

variable "backup_days" {
  type = string
}

variable "mysql_geo_backup" {
  default     = "Disabled"
  type        = string
  description = "Set to Enabled or Disabled"
}

variable "mysql_user" {
  default = "mysqladmin"
  type = string
}

variable "mysql_version" {
  type = string
}

variable "mysql_ssl" {
  type        = string
  description = "Set to Enabled or Disabled"
}

### Imported Variables
variable "region" {
  type = string
}

variable "rg_name" {
  type = string
}

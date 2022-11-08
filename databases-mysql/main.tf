# Random String for Password
# Please note this output will be stored in the state file.
resource "random_password" "database_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Create the Database Resource
resource "azurerm_mysql_server" "mysql_server" {
  name                = var.mysql_server_name
  location            = var.region
  resource_group_name = var.rg_name

  sku_name = var.sku_name

  storage_profile {
    storage_mb            = var.storage_mb
    backup_retention_days = var.backup_days
    geo_redundant_backup  = var.mysql_geo_backup
  }

  administrator_login          = var.mysql_user
  administrator_login_password = random_password.database_password.result
  version                      = var.mysql_version
  ssl_enforcement              = var.mysql_ssl
}

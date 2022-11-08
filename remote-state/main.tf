provider "azurerm" {
  version = "~>2.0"
  features {}
}

### Local Variables
locals {
  environment    = "${lookup(var.workspace_to_env_map, terraform.workspace, "sandbox")}"
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_loc

  tags = {
    Name        = var.rg_name
    Environment = local.environment
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type

  tags = {
    Name     = var.sa_name
    Enviroment = local.environment
  }
}

resource "azurerm_storage_container" "tf-state" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

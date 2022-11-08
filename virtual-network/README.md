# Virtual Network
This creates the Virtual Network and Subnets within Azure.

**NOTE**: Make sure to review variables.tf for some of the defaults related to the Storage Account

### Create vars file or entries in main.tf in root of repo
If you add a main.tf in the root of the repo, you can use the following as an example:
```
provider "azurerm" {
  version = "~>2.0"
  features {}
}

### Virtual Network
module "network" {
  source                 = "./virtual-network"
  network_name           = "sandbox-virtual-network"
  network_address_space  = "172.16.0.0/16"
  subnet_name            = "sandbox"
  region                 = "eastus2"
  rg_name                = "rg-sandbox"
}
```

**NOTE**: Make sure to modify any variables as needed.

If you used the `remote-state` folder in conjunction with the `virtual-network`, make sure to initialize your backend now!

```
terraform {
 backend "azurerm" {
    resource_group_name  = "<rg_name>"
    storage_account_name = "<sa_name>"
    container_name       = "<container_name>"
    key                  = "<state_file_name>"
  }
}
```

**NOTE**: Make sure to replace the values with the output from `remote-state`.

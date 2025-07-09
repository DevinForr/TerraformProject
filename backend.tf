terraform {
  backend "azurerm" {
    resource_group_name  = "rgroup-4010"                     # Update to match backend RG
    storage_account_name = "4010tfstatestore"            # Must exist
    container_name       = "tfstate"
    key                  = "assignment1-4010.tfstate"
  }
}
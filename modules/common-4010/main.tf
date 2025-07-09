resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "${var.humber_id}-logws"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.tags
}

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = "${var.humber_id}-rsvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = local.tags
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.humber_id}commonstore"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}
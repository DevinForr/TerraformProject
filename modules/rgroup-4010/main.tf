resource "azurerm_resource_group" "this" {
  name     = "rgroup-4010"
  location = var.location

tags = local.tags
}
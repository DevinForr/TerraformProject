resource "azurerm_resource_group" "this" {
  name     = "new_group-4010"
  location = var.location

tags = local.tags
}
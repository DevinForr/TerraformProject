output "virtual_network_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the virtual network"
}

output "subnet_name" {
  value       = azurerm_subnet.subnet.name
  description = "The name of the subnet"
}

output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "ID of the subnet"
}

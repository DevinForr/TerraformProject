output "hostname" {
  value       = azurerm_windows_virtual_machine.win_vm[0].name
  description = "Hostname of the Windows VM"
}

output "domain_name" {
  value       = azurerm_public_ip.win_pip[0].fqdn
  description = "DNS domain name of the Windows VM"
}

output "private_ip" {
  value       = azurerm_network_interface.win_nic[0].ip_configuration[0].private_ip_address
  description = "Private IP of the Windows VM"
}

output "public_ip" {
  value       = azurerm_public_ip.win_pip[0].ip_address
  description = "Public IP of the Windows VM"
}
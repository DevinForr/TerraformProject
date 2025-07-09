output "hostnames" {
  value = { for k, vm in azurerm_linux_virtual_machine.vm : k => vm.name }
}

output "domain_names" {
  value = { for k, pip in azurerm_public_ip.vm_pip : k => pip.fqdn }
}

output "private_ips" {
  value = { for k, nic in azurerm_network_interface.nic : k => nic.ip_configuration[0].private_ip_address }
}

output "public_ips" {
  value = { for k, pip in azurerm_public_ip.vm_pip : k => pip.ip_address }
}

output "nic_ids" {
  description = "NIC IDs for each Linux VM"
  value       = { for k, nic in azurerm_network_interface.nic : k => nic.id }
}

output "vm_ids" {
  value = {
    for idx, name in local.vm_names :
    name => azurerm_linux_virtual_machine.vm[idx].id
  }
}
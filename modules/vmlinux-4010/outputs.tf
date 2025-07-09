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

output "network_interface_ids" {
  value = {
    for k in local.vm_names :
    k => azurerm_network_interface.nic[k].id
  }
}

output "vm_ids" {
  value = {
    for name, vm in azurerm_linux_virtual_machine.vm :
    name => vm.id
  }
}
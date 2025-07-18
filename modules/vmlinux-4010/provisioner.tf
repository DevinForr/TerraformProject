locals {
  vm_names = ["vm1", "vm2", "vm3"]
}

resource "null_resource" "hostname_exec" {
  for_each = toset(local.vm_names)

    connection {
      type     = "ssh"
      host     = azurerm_public_ip.vm_pip[each.key].fqdn
#      host     = azurerm_linux_virtual_machine.vm[each.key].ip_address
      user     = "azureuser"
      password = "P@ssword123!"
    }

  provisioner "remote-exec" {
    inline = ["/usr/bin/hostname"]

  }

  depends_on = [
    azurerm_linux_virtual_machine.vm,
    azurerm_public_ip.vm_pip
  ]
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each = var.linux_vm_ids

  name                 = "network-watcher-${each.key}"
  virtual_machine_id   = each.value
  publisher            = "Microsoft.Azure.NetworkWatcher"
type                 = "NetworkWatcherAgentLinux"
type_handler_version = "1.4"
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each = var.linux_vm_ids

  name                 = "azure-monitor-${each.key}"
  virtual_machine_id   = each.value
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
}

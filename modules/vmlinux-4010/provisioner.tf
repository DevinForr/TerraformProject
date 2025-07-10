resource "null_resource" "hostname_exec" {
  for_each = toset(local.vm_names)

  provisioner "remote-exec" {
    inline = ["hostname"]

    connection {
      type     = "ssh"
      host     = azurerm_public_ip.vm_pip[each.key].ip_address
      user     = "azureuser"
      password = "P@ssw0rd!"
    }
  }

  depends_on = [
    azurerm_linux_virtual_machine.vm,
    azurerm_public_ip.vm_pip
  ]
}


resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each             = var.linux_vm_ids
  name                 = "network-watcher-${each.key}"
  virtual_machine_id   = each.value
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}

locals {
  vm_map = azurerm_linux_virtual_machine.vm
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each = local.vm_names.vm_ids

  name               = "azure-monitor-${each.key}"
  virtual_machine_id = each.value    # each.value is already the VM ID (string)
  publisher          = "Microsoft.Azure.Monitor"
  type               = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"
}
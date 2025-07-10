locals {
  vm_names = ["vm1", "vm2", "vm3"]
}

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

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_assoc" {
  #for_each = var.linux_nic_ids

  for_each = {
    vm1 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm1"
    vm2 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm2"
    vm3 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm3"
  }



  network_interface_id    = each.value
  ip_configuration_name   = "internal"
  backend_address_pool_id = var.backend_pool_id
}
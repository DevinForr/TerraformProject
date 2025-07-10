variable "humber_id" {
  type        = string
  description = "Humber ID last 4 digits"
    default     = "4010"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "East US"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "rgroup-4010"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to attach the NIC"
  default     = null
}

variable "nsg_id" {
  type        = string
  description = "Network Security Group ID (optional, if used)"
  default     = null
}

variable "diagnostics_storage_uri" {
  type        = string
  description = "URI of the storage account used for VM boot diagnostics"
    default     = null
}

variable "linux_vm_ids" {
  description = "Map of Linux VM names to their IDs"
  type        = map(string)
   default = {
    vm1 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Compute/virtualMachines/4010-vm1"
    vm2 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Compute/virtualMachines/4010-vm2"
    vm3 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Compute/virtualMachines/4010-vm3"
  }
}

variable "linux_nic_ids" {
  description = "Map of Linux VM names to their NIC IDs"
  type        = map(string)
  default = {
    vm1 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm1"
    vm2 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm2"
    vm3 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm3"
  }
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }


}

variable "backend_pool_id" {
  description = "ID of the backend address pool from the load balancer"
  type        = string
}
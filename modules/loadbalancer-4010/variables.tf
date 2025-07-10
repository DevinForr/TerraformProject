variable "humber_id" {
    description = "Last 4 digits of Humber ID"
    type        = string
    default     = "4010"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rgroup-4010"
}

variable "linux_nic_ids" {
  type = map(string)
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


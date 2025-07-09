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
  description = "Map of Linux VM NIC IDs (vm1, vm2, vm3)"
  type        = map(string)
  default     = {
    vm1 = "vm1-nic-id"
    vm2 = "vm2-nic-id"
    vm3 = "vm3-nic-id"
  }
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}
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
  type        = map(string)
  description = "Map of Linux VM IDs (vm0, vm1, vm2)"
  default     = {
    vm0 = "vm0-id"
    vm1 = "vm1-id"
    vm2 = "vm2-id"
  }
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}
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
  type        = map(string)
  description = "NICs of Linux VMs to attach to backend pool"
}
locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}


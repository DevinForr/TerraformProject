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

variable "subnet_id" {
  description = "ID of the subnet to attach the NIC"
  type        = string
  default     = null
}

variable "diagnostics_storage_uri" {
  description = "URI of the storage account used for VM boot diagnostics"
  type        = string
  default     = null
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}
variable "admin_username" {
  description = "Admin username"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Admin password (must meet Azure complexity requirements)"
  type        = string
  default     = "ComplexPassword123!" # Example, should be replaced with a secure password
}
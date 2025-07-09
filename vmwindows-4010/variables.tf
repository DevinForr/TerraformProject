variable "humber_id" {
  description = "Last 4 digits of Humber ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "diagnostics_storage_uri" {
  description = "Storage account URI for boot diagnostics"
  type        = string
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
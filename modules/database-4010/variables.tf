variable "humber_id" {
  default = "4010"
}

variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "4010-RG"
}

variable "admin_username" {
  default = "adminuser"
}

variable "admin_password" {
  default = "P@ssw0rd!"
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}

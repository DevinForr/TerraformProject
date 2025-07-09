variable "humber_id" {
    description = "Last 4 digits of Humber ID"
    type        = string
    default     = "4010"
}

variable "location" {
  default = "East US"   
}

variable "resource_group_name" {
  default = "rgroup-4010"
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}
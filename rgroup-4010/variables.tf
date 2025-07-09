variable "humber_id" {
  default = "4010"
  type        = string
}

variable "location" {
  default = "East US"
  type        = string
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}

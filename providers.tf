terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.20.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subid
  tenant_id       = var.tenid
}

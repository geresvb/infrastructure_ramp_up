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

  subscription_id = "15158422-ef98-425f-a0e3-6e53c81ba478"
  tenant_id       = "0b3fc178-b730-4e8b-9843-e81259237b77"
}

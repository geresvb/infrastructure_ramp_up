resource "azurerm_resource_group" "RG_1" {
  name     = "Terraform_Infrastructure_test"
  location = "East US"
  tags = {
    Tower   = "Wintel"
    Owner   = "ValdesG"
    project = "Terraform"
  }
}
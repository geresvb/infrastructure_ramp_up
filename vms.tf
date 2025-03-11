#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine


#DB
resource "azurerm_linux_virtual_machine" "dbvm" {
  name                = "DB-VM1"
  resource_group_name = azurerm_resource_group.RG_1.name
  location            = azurerm_resource_group.RG_1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic_1.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("./keys/dbkey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(file("./cloudinit/database.yaml"))
}




#Backend
resource "azurerm_linux_virtual_machine" "BackendVM" {
  name                = "Backend-VM1"
  resource_group_name = azurerm_resource_group.RG_1.name
  location            = azurerm_resource_group.RG_1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic_2.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("./keys/backend.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(file("./cloudinit/backend.yaml"))

}




#Frontend
resource "azurerm_linux_virtual_machine" "FrontendVM" {
  name                = "Frontend-VM1"
  resource_group_name = azurerm_resource_group.RG_1.name
  location            = azurerm_resource_group.RG_1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic_3.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("./keys/frontendkey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(file("./cloudinit/frontend.yaml"))

}



#Management
resource "azurerm_linux_virtual_machine" "ManagementVM" {
  name                = "Management-VM1"
  resource_group_name = azurerm_resource_group.RG_1.name
  location            = azurerm_resource_group.RG_1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic_4.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("./keys/managementkey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  #custom_data = base64encode(file("./cloudinit/docker.yaml"))

}
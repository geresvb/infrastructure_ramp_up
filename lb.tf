# Public IP for Load Balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "PublicIP-LB"
  location            = azurerm_resource_group.RG_1.location
  resource_group_name = azurerm_resource_group.RG_1.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Load Balancer
resource "azurerm_lb" "frontend_lb" {
  name                = "Frontend-LB"
  location            = azurerm_resource_group.RG_1.location
  resource_group_name = azurerm_resource_group.RG_1.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "FrontendConfig"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

# Backend Pool
resource "azurerm_lb_backend_address_pool" "frontend_backend_pool" {
  loadbalancer_id = azurerm_lb.frontend_lb.id
  name            = "FrontendBackendPool"
}

# NIC Association with Backend Pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_3_to_lb" {
  network_interface_id    = azurerm_network_interface.nic_3.id
  ip_configuration_name   = "NIC_Frontend"
  backend_address_pool_id = azurerm_lb_backend_address_pool.frontend_backend_pool.id
}

# Load Balancer Rule: Allow SSH Traffic
resource "azurerm_lb_rule" "allow_ssh" {
  loadbalancer_id                = azurerm_lb.frontend_lb.id
  name                           = "Allow-SSH"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 22
  frontend_ip_configuration_name = "FrontendConfig"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.frontend_backend_pool.id]
  probe_id                       = azurerm_lb_probe.ssh_probe.id
}

# Load Balancer Probe: SSH
resource "azurerm_lb_probe" "ssh_probe" {
  loadbalancer_id = azurerm_lb.frontend_lb.id
  name            = "SSH-Probe"
  protocol        = "Tcp"
  port            = 22
}

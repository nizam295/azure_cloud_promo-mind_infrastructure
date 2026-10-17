# File: main.tf

# 1. Provision the primary Azure Resource Group container
resource "azurerm_resource_group" "prod_group" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Deploy the core Virtual Network (VNet) boundary
resource "azurerm_virtual_network" "prod_vnet" {
  name                = "PromoMind-Production-VNet"
  location            = azurerm_resource_group.prod_group.location
  resource_group_name = azurerm_resource_group.prod_group.name
  address_space       = var.vnet_address_space
}

# 3. Layer 1 Subnet: Public Web Subnet (Houses Load Balancer)
resource "azurerm_subnet" "public_subnet" {
  name                 = "Public-Web-Subnet-01"
  resource_group_name  = azurerm_resource_group.prod_group.name
  virtual_network_name = azurerm_virtual_network.prod_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 4. Layer 2 Subnet: Private Isolated Subnet (Houses Hidden Compute/App Services)
resource "azurerm_subnet" "private_subnet" {
  name                 = "Private-App-Subnet-02"
  resource_group_name  = azurerm_resource_group.prod_group.name
  virtual_network_name = azurerm_virtual_network.prod_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# 5. Provision the Network Security Group (Firewall Shield)
resource "azurerm_network_security_group" "production_nsg" {
  name                = "PromoMind-Production-NSG"
  location            = azurerm_resource_group.prod_group.location
  resource_group_name = azurerm_resource_group.prod_group.name

  # Security Rule 1: Allow basic HTTP web browser entrance
  security_rule {
    name                       = "Allow-HTTP-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Security Rule 2: Allow secure HTTPS traffic
  security_rule {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Security Rule 3: Block everything else coming from the open public web
  security_rule {
    name                       = "Deny-All-Internet-Default"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

# 6. Bind the Security Group to protect your Private Subnet tier
resource "azurerm_subnet_network_security_group_association" "nsg_bind" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.production_nsg.id
}

# 7. Provision a Public IP for the External Traffic Load Balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "PromoMind-LB-PublicIP"
  location            = azurerm_resource_group.prod_group.location
  resource_group_name = azurerm_resource_group.prod_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# 8. Deploy the Public Load Balancer inside the Public Subnet Tier
resource "azurerm_lb" "public_lb" {
  name                = "PromoMind-External-LoadBalancer"
  location            = azurerm_resource_group.prod_group.location
  resource_group_name = azurerm_resource_group.prod_group.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LB-Frontend-Config"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

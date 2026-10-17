# File: outputs.tf

output "resource_group_name" {
  value       = azurerm_resource_group.prod_group.name
  description = "The verified name of your deployed production Resource Group"
}

output "vnet_id" {
  value       = azurerm_virtual_network.prod_vnet.id
  description = "The unique tracking ID assigned by Azure to your Virtual Network"
}

output "public_ip_address" {
  value       = azurerm_public_ip.lb_public_ip.ip_address
  description = "The static public facing IP assigned to your External Load Balancer"
}

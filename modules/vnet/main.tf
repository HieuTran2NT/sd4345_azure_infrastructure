module "network" {
  source  = "Azure/network/azurerm"
  version = "3.5.0"

  resource_group_name = var.resource_group_name
  vnet_name           = var.vnets[0].name         
  address_space       = var.vnets[0].cidr_block   
  subnet_prefixes     = var.vnets[0].subnets_cidr 
  subnet_names        = var.vnets[0].subnets_name
}

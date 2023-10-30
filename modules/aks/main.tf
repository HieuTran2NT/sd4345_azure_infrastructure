
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "7.4.0"
  prefix                    = var.prefix
  resource_group_name       = var.resource_group_name
  kubernetes_version        = var.kubernetes_version
  automatic_channel_upgrade = var.automatic_channel_upgrade
  attached_acr_id_map = {
    acr_id = var.acr_id
  }
  public_network_access_enabled = var.public_network_access_enabled
  network_plugin                = var.network_plugin
  network_policy                = var.network_policy
  os_disk_size_gb               = var.os_disk_size_gb
  sku_tier                      = var.sku_tier
  rbac_aad                      = var.rbac_aad
  vnet_subnet_id                = var.vnet_subnet_id
  agents_availability_zones     = var.agents_availability_zones 
  agents_size                   = var.agents_size     
  agents_count                  = var.agents_count
  temporary_name_for_rotation   = var.temporary_name_for_rotation
}
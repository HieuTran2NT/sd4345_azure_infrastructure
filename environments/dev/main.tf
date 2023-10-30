
locals {
  prefix              = "pishaped"
  env                 = "dev"
  location           = "Southeast Asia"
  vnet_name           = "${local.prefix}-${local.env}-vnet01"
  resource_group_name = "${local.prefix}-rg01"
  acr_name            = "${local.prefix}${local.env}acr01"
}

module "resource_group" {
  source          = "../../modules/resource_group"
  name            = local.resource_group_name
  location        = local.location
}
module "network" {
  source = "../../modules/vnet"
  resource_group_name = module.resource_group.name
  depends_on = [ module.resource_group ]
  vnets = [
    {
      name       = local.vnet_name
      cidr_block = "172.24.0.0/16"

      subnets_cidr = [
        "172.24.5.0/24",
        "172.24.6.0/24",
        "172.24.7.0/24",
        "172.24.8.0/24"
      ],

      subnets_name = [
        "pishaped-sn01",
        "pishaped-sn02",
        "pishaped-sn03",
        "pishaped-sn04"
      ]
    }
  ]
}

module "acr" {
  source = "../../modules/acr"
  name = local.acr_name
  resource_group_name = module.resource_group.name
  location = local.location
  sku      = "Basic"
}

module "aks" {
  source = "../../modules/aks"
  prefix = local.prefix
  resource_group_name = local.resource_group_name
  kubernetes_version = "1.26"
  acr_id = module.acr.id
  vnet_subnet_id = module.network.vnet_subnet_id[0]
  agents_availability_zones = ["2","3"]
  temporary_name_for_rotation = "tmlagentpool"
}
data "azurerm_kubernetes_cluster" "default" {
  # depends_on          = [module.aks] # refresh cluster state before reading
  name                = "pishaped-aks"
  resource_group_name = local.resource_group_name
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}
module "argocd" {
source = "../../modules/argocd"
# depends_on = [ module.aks ]
}

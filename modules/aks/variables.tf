variable "prefix" {
}
variable "resource_group_name" {
}
variable "kubernetes_version" {
}
variable "acr_id" {  
}
variable "vnet_subnet_id" {
}
variable "agents_availability_zones" {
  type = list(string)
}
variable "public_network_access_enabled" {
  type = bool
  default = true
}
variable "os_disk_size_gb" {
  default = 60
}
variable "sku_tier" {
  default = "Standard"
}
variable "rbac_aad" {
  type = bool
  default = false
}
variable "network_plugin" {
  default = "azure"
}
variable "network_policy" {
  default = "azure"
}
variable "automatic_channel_upgrade" {
  default = "patch"
}
variable "agents_size" {
  default = "standard_b2s"
}
variable "agents_count" {
  default = 1
}
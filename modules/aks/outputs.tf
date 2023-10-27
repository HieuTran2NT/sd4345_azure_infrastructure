# output "kubelet_identity" {
#   value       = module.aks.kubelet_identity.0.object_id
#   description = "The kubelet identity."
# }

# output "aks_name" {
#   value       = module.aks.name
#   description = "Name of the AKS cluster"
# }

# output "aks_config" {
#   value       = module.aks.kube_config.0
#   sensitive   = true
#   description = "AKS Config object"
# }

# output "kubectl_config" {
#   value = module.aks.kube_config_raw
# }


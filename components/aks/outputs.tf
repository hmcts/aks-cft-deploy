output "clusters" {
  value     = join(" ", flatten([for cluster in module.kubernetes : cluster[*].cluster]))
  sensitive = false
}

output "kubelet_object_ids" {
  value     = join(",", flatten([for cluster in module.kubernetes : cluster[*].kubelet_object_id]))
  sensitive = false
}
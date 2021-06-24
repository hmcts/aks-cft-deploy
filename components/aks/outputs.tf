output "clusters" {
  value     = join(" ", module.kubernetes[*].cluster)
  sensitive = false
}

output "kubelet_object_ids" {
  value     = join(" ", module.kubernetes[*].kubelet_object_id)
  sensitive = false
}
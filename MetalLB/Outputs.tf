output "metallb_namespace" {
  value = kubernetes_namespace.metallb-system.metadata.0.name
}
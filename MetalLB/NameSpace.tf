#namespace: metallb-system
resource "kubernetes_namespace" "metallb-system" {
    metadata {
      name = "metallb-system"

      labels = {
          app = "metallb"
      }
    }
}
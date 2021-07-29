#ServiceAccount: controller
resource "kubernetes_service_account" "controller" {
    metadata {
      name = "controller"
      namespace = kubernetes_namespace.metallb-system.metadata.0.name

      labels = {
          app = "metallb"
      }
    }
}

#ServiceAccount: speaker
resource "kubernetes_service_account" "speaker" {
    metadata {
        name = "speaker"
        namespace = kubernetes_namespace.metallb-system.metadata.0.name
        
        labels = {
          app = "metallb"
        }
    }

}

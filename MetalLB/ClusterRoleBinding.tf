#ClusterRoleBiding: controller
resource "kubernetes_cluster_role_binding" "controller" {
  metadata {
    name = "metallb-system:controller"
    labels = {
        app = "metallb"
    }
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "metallb-system:controller"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "controller"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
  }
}

#ClusterRoleBinding: speaker
resource "kubernetes_cluster_role_binding" "speaker" {
  metadata {
    name = "metallb-system:speaker"
    labels = {
        app = "metallb"
    }
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "metallb-system:speaker"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "speaker"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
  }
}
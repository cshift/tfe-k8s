resource "kubernetes_role_binding" "config-watcher" {
  metadata {
    name      = "config-watcher"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name

    labels = {
      "app" = "metallb"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "config-watcher"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.controller.metadata.0.name
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.speaker.metadata.0.name
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
  }
}


resource "kubernetes_role_binding" "pod-lister" {
  metadata {
    name      = "pod-lister"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name

    labels = {
      "app" = "metallb"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "pod-lister"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.speaker.metadata.0.name
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
  }
}


resource "kubernetes_role_binding" "controller" {
  metadata {
    name      = "controller"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name

    labels = {
      "app" = "metallb"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "controller"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.controller.metadata.0.name
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
  }
}
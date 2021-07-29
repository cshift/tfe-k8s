#Role: config-watcher
resource "kubernetes_role" "config-watcher" {
  metadata {
    name = "config-watcher"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
    labels = {
      app = "metallb"
    }
  }

  rule {
    api_groups     = [""]
    resources      = ["configmaps"]
    verbs          = ["get", "list", "watch"]
  }
}

#Role: pod-lister
resource "kubernetes_role" "pod-lister" {
  metadata {
    name = "pod-lister"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
    labels = {
      app = "metallb"
    }
  }

  rule {
    api_groups     = [""]
    resources      = ["pods"]
    verbs          = ["list"]
  }
}

#Role: controller
resource "kubernetes_role" "controller" {
  metadata {
    name = "controller"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
    labels = {
      app = "metallb"
    }
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    verbs          = ["create"]
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["memberlist"]
    verbs          = ["list"]
  }

  rule {
    api_groups     = ["apps"]
    resources      = ["deployments"]
    resource_names = ["controller"]
    verbs          = ["get"]
  }

}

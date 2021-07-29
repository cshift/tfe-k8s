#ClusterRole: metallb-system:controller
resource "kubernetes_cluster_role" "controller" {
  metadata {
      name = "metallb-system:controller"
      
      labels = {
        app = "metallb"
      }
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups  = [""]
    resources   = ["services/status"]
    verbs       = ["update"]
  }

  rule {
    api_groups  = [""]
    resources   = ["events"]
    verbs       = ["create", "patch"]
  }

  rule {
    api_groups  = ["policy"]
    resource_names = ["controller"]
    resources = ["podsecuritypolicies"]
    verbs = [ "use" ]
  }
}

#ClusterRole: metallb-system: speaker
resource "kubernetes_cluster_role" "speaker" {
  metadata {
      name = "metallb-system:speaker"
      labels = {
        app = "metallb"
      }
  }

  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "nodes"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups  = ["discovery.k8s.io"]
    resources   = ["endpointslices"]
    verbs       = ["get", "list", "watch"]
  }

  rule {
    api_groups  = [""]
    resources   = ["events"]
    verbs       = ["create", "patch"]
  }

  rule {
    api_groups  = ["policy"]
    resource_names = [ "speaker" ]
    resources = [ "podsecuritypolicies" ]
    verbs = [ "use" ]
  }
}
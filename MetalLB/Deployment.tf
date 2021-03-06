resource "kubernetes_deployment" "controller" {
  metadata {
    name      = "controller"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
 
    labels = {
      app       = "metallb"
      component = "controller"
    }
  }

  spec {
    revision_history_limit = 3

    selector {
      match_labels = {
        app       = "metallb"
        component = "controller"
      }
    }

    template {
      metadata {
        annotations = {
          "prometheus.io/port"   = "7472"
          "prometheus.io/scrape" = "true"
        }
        labels = {
          app       = "metallb"
          component = "controller"
        }
      }

      spec {
        container {
          args = [
            "--port=7472",
            "--config=config",
          ]

          env {
            name  = "METALLB_ML_SECRET_NAME"
            value = "memberlist"
          }

          env {
            name  = "METALLB_DEPLOYMENT"
            value = "controller"
          }
          
          image = "quay.io/metallb/controller:v${var.metallb_version}"
          name  = "controller"

          port {
            name           = "monitoring"
            container_port = 7472
          }

          security_context {
            allow_privilege_escalation = false
            capabilities {
              drop = ["ALL"]
            }
            read_only_root_filesystem = true
          }
        }

        node_selector = merge(
          { "kubernetes.io/os" = "linux" },
          var.controller_node_selector
        )

        security_context {
          run_as_non_root = true
          run_as_user     = 65534
        }

        service_account_name             = "controller"
        termination_grace_period_seconds = 0

        automount_service_account_token  = true # override Terraform's default false - https://github.com/kubernetes/kubernetes/issues/27973#issuecomment-462185284
      }
    }
  }
}
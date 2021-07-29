resource "kubernetes_daemonset" "speaker" {
  metadata {
    name      = "speaker"
    namespace = kubernetes_namespace.metallb-system.metadata.0.name
    
    labels = {
      app       = "metallb"
      component = "speaker"
    }
  }

  spec {
    selector {
      match_labels = {
        app       = "metallb"
        component = "speaker"
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
          component = "speaker"
        }
      }

      spec {
        container {
          args = [
            "--port=7472",
            "--config=config",
          ]

          env {
            name = "METALLB_NODE_NAME"
            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }

          env {
            name = "METALLB_HOST"
            value_from {
              field_ref {
                field_path = "status.hostIP"
              }
            }
          }

          env {
            name = "METALLB_ML_BIND_ADDR"
            value_from {
              field_ref {
                field_path = "status.podIP"
              }
            }
          }

          env {
            name  = "METALLB_ML_LABELS"
            value = "app=metallb,component=speaker"
          }

          env {
            name = "METALLB_ML_SECRET_KEY"
            value_from {
              secret_key_ref {
                name = "memberlist"
                key  = "secretkey"
              }
            }
          }

          image = "quay.io/metallb/speaker:v0.10.2"
          name  = "speaker"

          port {
            name           = "monitoring"
            container_port = 7472
            host_port      = 7472
          }

          port {
            name           = "memberlist-tcp"
            container_port = 7946
            # host_port      = 7946
          }

          port {
            name           = "memberlist-udp"
            protocol       = "UDP"
            container_port = 7946
            # host_port      = 7946
          }

          security_context {
            allow_privilege_escalation = false
            capabilities {
              add  = ["NET_RAW"]
              drop = ["ALL"]
            }
            read_only_root_filesystem = true
          }
        }

        host_network                     = true
        
        node_selector = {
          "kubernetes.io/os" = "linux"
        }

        service_account_name             = "speaker"

        termination_grace_period_seconds = 2

        toleration {
          key      = "node-role.kubernetes.io/master"
          effect   = "NoSchedule"
          operator = "Exists"
        }

        # override Terraform's default false - https://github.com/kubernetes/kubernetes/issues/27973#issuecomment-462185284
        automount_service_account_token  = true 
      }
    }
  }
}
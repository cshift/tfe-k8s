# MetalLB Module 호출
module "MetalLB" {
    source = "./MetalLB"
    lb_ipaddr = "192.168.56.247-192.168.56.249"
}

# NGINX Deployment
resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-deployment"
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginxdemos/hello:plain-text"
          name  = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

## Deploy 한 NGINX 를 'Load Balancer' type의 Service 로 Expose
resource "kubernetes_service" "nginx_as_lb" {
    metadata {
      name = "nginx-service"
      annotations = {
        "metallb.universe.tf/address-pool" = "default"
        "metallb.universe.tf/allow-shared-ip" = "shared"
      }
    }

    spec {
        selector = {
            ## 위에서 생성한 NGINX 지정
            app = kubernetes_deployment.nginx.metadata.0.labels.app
        }

        port {
          port  = 80
          target_port = 80
        }

        type = "LoadBalancer"
    }
}

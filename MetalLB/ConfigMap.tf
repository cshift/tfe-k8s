# resource "kubernetes_config_map" "config" {
#     metadata {
#         name = "config"
#         namespace = kubernetes_namespace.metallb-system.metadata.0.name
#     }

#     data = {
#         "config" = "${file("${path.module}/config.yaml")}"
#     }
# }

resource "kubernetes_config_map" "config" {
    metadata {
        name = "config"
        namespace = kubernetes_namespace.metallb-system.metadata.0.name
    }

    data = {
        "config" = <<EOF
address-pools:
- name: default
  protocol: layer2
  addresses:
  - 192.168.56.247-192.168.56.249
EOF
    }
}


## Metal LB Module 에서 생성된 namespace 'metallb-system' 정보를 Module 밖에서 호출 하기 위해 output 생성

output "metallb_namespace" {
  value = kubernetes_namespace.metallb-system.metadata.0.name
}

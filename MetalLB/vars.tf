## MetalLB 생성에 필요한 변수 설정, 필요에 따라 hard coding 해도 무방

variable "lb_ipaddr" {
    type = string
    default = "<Static IP addr for LB - xxx.xxx.xxx.xxx>"
    
    description = "Static IP for MetalLB"
}

variable "metallb_version" {
    type = string
    default = "0.10.2"
}

variable "controller_node_selector" {
    type    = map(any)
    default = {}
}

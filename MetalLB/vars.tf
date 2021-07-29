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

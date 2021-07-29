variable "lb_ipaddr" {
    type = string
    default = "192.168.56.115"
    
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
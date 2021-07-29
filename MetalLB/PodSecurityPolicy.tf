#PodSecurityPolicy: controller
resource "kubernetes_pod_security_policy" "controller" {
  metadata {
    name = "controller"

    labels = {
      "app" = "metallb"
    }
  }

  spec {
    allow_privilege_escalation = false
    allowed_capabilities = []
#    allowed_host_paths {
#      path_prefix = ""
#    }
    
    default_add_capabilities = []
    default_allow_privilege_escalation = false
    
    fs_group {
      rule = "MustRunAs"
      range {
        min = 1
        max = 65535
      }
    }

    host_ipc = false
    host_network = false
    host_pid = false
    privileged = false
    read_only_root_filesystem = true

    required_drop_capabilities = [ "ALL" ]
        
    run_as_user {
      rule = "MustRunAs"
      range {
        min = 1
        max = 65535
      }
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      rule = "MustRunAs"
      range {
        min = 1
        max = 65535
      }
    }

    volumes = [
      "configMap",
      "emptyDir",
      "secret"
    ]
  }
}

#PodSecurityPolicy
resource "kubernetes_pod_security_policy" "speaker" {
  metadata {
    name = "speaker"

    labels = {
      "app" = "metallb"
    }
  }

  spec {
    allow_privilege_escalation = false
    allowed_capabilities = [ "NET_RAW" ] 
#    allowed_host_paths {
#      path_prefix = ""
#    }
    
    default_add_capabilities = []
    default_allow_privilege_escalation = false
    
    fs_group {
      rule = "RunAsAny"
    }

    host_ipc = false
    host_network = true
    host_pid = false
    
    host_ports {
      max = 7472
      min = 7472
    }

    host_ports {
      max = 7946
      min = 7946
    }

    privileged = true
    read_only_root_filesystem = true

    required_drop_capabilities = [ "ALL" ]
        
    run_as_user {
      rule = "RunAsAny"
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      rule = "RunAsAny"
    }

    volumes = [
      "configMap",
      "emptyDir",
      "secret"
    ]
  }
}
terraform {
  ## TFE 환경 관련 정보 입력
  backend "remote" {
    hostname = "<TFE HOST 주소>"
    organization = "<organization 명>"

    workspaces {
      name = "<workspace 명>"
    }
  }
  
  ## 사용할 Provider (kubernetes) 와 version 정보
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.3.1"
    }
  }
}

## kubernetes provider 정의 - k8s master node 에 저장된 config 정보 복사하여 Terraform 설치된 local machine 에 저장 후 위치 지정 
provider "kubernetes" {
    config_path = "~/.kube/config"
}

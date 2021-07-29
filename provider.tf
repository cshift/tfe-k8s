terraform {
  backend "remote" {
    hostname = "tfe.cshift.co"
    organization = "cloudshift"

    workspaces {
      name = "test-tfe-k8s"
    }
  }

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.3.1"
    }
  }
}

provider "kubernetes" {
    config_path = "~/.kube/config"
}

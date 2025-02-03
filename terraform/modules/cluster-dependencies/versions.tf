terraform {
  required_version = ">= 1.9.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.34.0"
    }
    
    # in module: terraform-aws-eks-blueprints-addon
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "minikube"
    # host                   = module.eks.cluster_endpoint
    # cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    # exec {
    #   api_version = "client.authentication.k8s.io/v1beta1"
    #   command     = "aws"
    #   # This requires the awscli to be installed locally where Terraform is executed
    #   args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    # }
  }
}

# can not use kubernetes provider with resource kubernetes_manifest 
# due to https://github.com/hashicorp/terraform-provider-kubernetes/issues/1775
provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "minikube"
  # host                   = module.eks.cluster_endpoint
  # cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "aws"
  #   # This requires the awscli to be installed locally where Terraform is executed
  #   args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  # }
}

provider "kubectl" {
  # apply_retry_count      = 5
  # host                   = module.eks.cluster_endpoint
  # cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  load_config_file       = true
  config_path = "~/.kube/config"
  config_context = "minikube"

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "aws"
  #   # This requires the awscli to be installed locally where Terraform is executed
  #   args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  # }
}
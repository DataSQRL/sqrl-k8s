resource "kubernetes_namespace" "cnpg-system" {
  metadata {
    name = "cnpg-system"
  }
}

# cnpg operator
module "cnpg_operator" {
  source = "aws-ia/eks-blueprints-addon/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  chart         = "cloudnative-pg"
  chart_version = "0.22.1"
  repository    = "https://cloudnative-pg.github.io/charts"
  description   = "CNPG operator"
  namespace     = "cnpg-system"
  wait = true

  values = []
  depends_on = [kubernetes_namespace.cnpg-system]
}
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

  values = [
    <<-EOT
      config:
        create: true
        name: cnpg-controller-manager-config
        secret: false
        clusterWide: true
        data:
          INHERITED_ANNOTATIONS: categories
          INHERITED_LABELS: environment, group, organization_id, deployment_id, monitoring_enabled, service, short_id
          ENABLE_INSTANCE_MANAGER_INPLACE_UPDATES: 'true'
    EOT
  ]
#   set = [
#     {
#       name  = "replicas"
#       value = 3
#     }
#   ]
tags = local.common_tags

depends_on = [kubernetes_namespace.cnpg-system]
}

# Namespaces

resource "kubernetes_namespace" "cnpg-system" {
  metadata {
    name = "cnpg-system"
  }
  depends_on = [time_sleep.eks_cluster_available]
}
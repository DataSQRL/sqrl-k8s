data "template_file" "flink_operator_values_yaml" {
  template = "${file("${path.module}/values/flink-operator-values.yaml.tpl")}"
  vars = {
    flink_operator_sa_role_arn = local.cluster_node_group_core_iam_arn
  }
}


module "flink_operator" {
  source = "aws-ia/eks-blueprints-addon/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  chart         = "flink-kubernetes-operator"
  chart_version = "1.9.0"
  repository    = "https://downloads.apache.org/flink/flink-kubernetes-operator-1.9.0/"
  description   = "Flink operator"
  namespace     = "flink"
  wait = true

  values = [
    <<-EOT
      ${data.template_file.flink_operator_values_yaml.rendered}
    EOT
  ]

  tags = local.common_tags

  depends_on = [kubernetes_namespace.flink]
}

# Namespaces

resource "kubernetes_namespace" "flink" {
  metadata {
    name = "flink"
  }
  depends_on = [time_sleep.eks_cluster_available]
}
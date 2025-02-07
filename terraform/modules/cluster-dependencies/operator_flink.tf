resource "kubernetes_namespace" "flink" {
  metadata {
    name = "flink"
  }
}

data "template_file" "flink_operator_values_yaml" {
  template = "${file("${path.module}/values/flink-operator-values.yaml.tpl")}"
}


module "flink_operator" {
  source = "aws-ia/eks-blueprints-addon/aws"
  version = "~> 1.0"

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

  depends_on = [kubernetes_namespace.flink]
}
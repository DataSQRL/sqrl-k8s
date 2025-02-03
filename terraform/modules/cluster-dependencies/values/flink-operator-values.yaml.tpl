defaultConfiguration:
  create: true
  append: true
  flink-conf.yaml: |+
    # trial fix for finalizer deletion issue
    kubernetes.operator.job.upgrade.ignore-pending-savepoint: true
    kubernetes.operator.job.savepoint-on-deletion: false

    kubernetes.operator.dynamic.namespaces.enabled: true
    kubernetes.operator.metrics.reporter.prom.factory.class: org.apache.flink.metrics.prometheus.PrometheusReporterFactory
    kubernetes.operator.metrics.reporter.prom.port: 9999
    kubernetes.operator.metrics.reporter.prom.interval: 5 MINUTE

    kubernetes.operator.flink.client.timeout: 5 MINUTE

webhook:
  create: false

operatorServiceAccount:
  create: true
  annotations:
    "helm.sh/resource-policy": delete
    "eks.amazonaws.com/role-arn": "${flink_operator_sa_role_arn}"
  name: "flink-operator"

# jobServiceAccount:
#   create: true
#   annotations:
#     "helm.sh/resource-policy": delete
#     "eks.amazonaws.com/role-arn": arn:aws:iam::286928876767:role/eksctl-datasqrl-cloud-nodegroup-my-NodeInstanceRole-dNZzJBfWsGTC
#   name: "flink"

rbac:
  create: true
  nodesRule:
    create: false
  operatorRole:
    create: true
    name: "flink-operator"
  operatorRoleBinding:
    create: true
    name: "flink-operator-role-binding"
  jobRole:
    create: true
    name: "flink"
  jobRoleBinding:
    create: true
    name: "flink-role-binding"

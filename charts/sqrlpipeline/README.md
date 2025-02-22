# datasqrl-sqrlpipeline

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for datasqrl pipeline stack

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Tianchen | <tianchen@datasqrl.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| engine.database.logging.level | string | `"info"` |  |
| engine.flink.enable_high_availability | bool | `false` |  |
| engine.flink.flinkConfiguration."fs.s3a.aws.credentials.provider" | string | `"org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider"` |  |
| engine.flink.flinkConfiguration."jobmanager.memory.process.size" | string | `"512m"` |  |
| engine.flink.flinkConfiguration."metrics.reporter.prom.factory.class" | string | `"org.apache.flink.metrics.prometheus.PrometheusReporterFactory"` |  |
| engine.flink.flinkConfiguration."metrics.reporter.prom.interval" | string | `"1 MINUTE"` |  |
| engine.flink.flinkConfiguration."metrics.reporter.prom.port" | string | `"9249"` |  |
| engine.flink.flinkConfiguration."metrics.reporters" | string | `"prom"` |  |
| engine.flink.flinkConfiguration."taskmanager.memory.process.size" | string | `"512m"` |  |
| engine.flink.flinkConfiguration."taskmanager.numberOfTaskSlots" | string | `"1"` |  |
| engine.flink.jobManager.resource.cpu | float | `0.5` |  |
| engine.flink.jobManager.resource.memory | string | `"1g"` |  |
| engine.flink.logging.format | string | `"json"` |  |
| engine.flink.logging.level | string | `"info"` |  |
| engine.flink.taskManager.resource.cpu | float | `0.5` |  |
| engine.flink.taskManager.resource.memory | string | `"1g"` |  |
| engine.flink.version | string | `"v1_19"` |  |
| engine.server.metrics.path | string | `"metrics"` |  |
| engine.server.metrics.port | int | `8888` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

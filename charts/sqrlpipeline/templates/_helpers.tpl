{{- define "sqrlpipeline.short_id" -}}
{{ .Values.deployment.deploymentName }}
{{- end -}}

{{- define "sqrlpipeline.deployment_id" -}}
{{ .Values.deployment.deploymentId }}
{{- end -}}

{{- define "sqrlpipeline.name_suffix" -}}
{{ include "sqrlpipeline.short_id" . }}
{{- end -}}

{{- define "sqrlpipeline.dns_name" -}}
{{ .Values.deployment.hostDomain }}
{{- end -}}

{{- define "sqrlpipeline.flinksessionjob_name" -}}
session-cluster-job-{{ include "sqrlpipeline.name_suffix" . }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "sqrlpipeline.base_common_labels" -}}
group: {{ .Values.group_label }}
organization_id: {{ .Release.Namespace }}
short_id: {{ include "sqrlpipeline.short_id" . }}
deployment_id: {{ include "sqrlpipeline.deployment_id" . }}
monitoring_enabled: {{ .Values.metadata.labels.monitoring.enabled | quote }}
environment: {{ .Values.environment }}
{{- end -}}
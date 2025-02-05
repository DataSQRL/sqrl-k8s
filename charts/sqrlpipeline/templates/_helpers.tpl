{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "sqrlpipeline.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

# {{/*
# Create a default fully qualified app name.
# We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
# If release name contains chart name it will be used as a full name.
# */}}
# {{- define "sqrlpipeline.fullname" -}}
# {{- if .Values.fullnameOverride -}}
# {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
# {{- else -}}
# {{- $name := default .Chart.Name .Values.nameOverride -}}
# {{- if contains $name .Release.Name -}}
# {{- .Release.Name | trunc 63 | trimSuffix "-" -}}
# {{- else -}}
# {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
# {{- end -}}
# {{- end -}}
# {{- end -}}


{{- define "sqrlpipeline.short_id" -}}
{{ .Values.deployment.deploymentName }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sqrlpipeline.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "sqrlpipeline.name_suffix" -}}
{{ include "sqrlpipeline.short_id" . }}
{{- end -}}



{{- define "sqrlpipeline.flinksessionjob_name" -}}
session-cluster-job-{{ include "sqrlpipeline.name_suffix" . }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "sqrlpipeline.base_common_labels" -}}
short_id: {{ include "sqrlpipeline.short_id" . }}
helm.sh/chart: {{ include "sqrlpipeline.chart" . }}
{{ include "sqrlpipeline.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "sqrlpipeline.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sqrlpipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
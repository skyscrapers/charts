{{/* vim: set filetype=mustache: */}}

{{/*
Filter on tag if specified
*/}}
{{- define "elasticache-monitoring.filterOnTag" -}}
{{- if .Values.tagFilter -}}
* on (dbinstance_identifier, instance) aws_resource_info{job="{{ .Release.Name }}-prometheus-cloudwatch-exporter", tag_{{ .Values.tagFilter.key }}="{{ .Values.tagFilter.value }}"}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "elasticache-monitoring.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "elasticache-monitoring.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "elasticache-monitoring.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "elasticache-monitoring.labels" -}}
helm.sh/chart: {{ include "elasticache-monitoring.chart" . }}
{{ include "elasticache-monitoring.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "elasticache-monitoring.selectorLabels" -}}
app.kubernetes.io/name: {{ include "elasticache-monitoring.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "elasticache-monitoring.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "elasticache-monitoring.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Alert labels
*/}}
{{- define "elasticache-monitoring.alertLabels" -}}
group: persistence
{{- if .Values.sla }}
sla: {{ .Values.sla }}
{{- end }}
{{- if .Values.alertsLabels }}
{{ toYaml .Values.alertsLabels }}
{{- end }}
{{- end }}

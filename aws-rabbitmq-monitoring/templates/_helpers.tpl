{{/*
Expand the name of the chart.
*/}}
{{- define "aws-rabbitmq-monitoring.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "aws-rabbitmq-monitoring.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aws-rabbitmq-monitoring.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "aws-rabbitmq-monitoring.labels" -}}
helm.sh/chart: {{ include "aws-rabbitmq-monitoring.chart" . }}
{{ include "aws-rabbitmq-monitoring.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "aws-rabbitmq-monitoring.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aws-rabbitmq-monitoring.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "aws-rabbitmq-monitoring.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "aws-rabbitmq-monitoring.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Alert labels
*/}}
{{- define "aws-rabbitmq-monitoring.alertLabels" -}}
group: persistence
severity: critical
{{- if .Values.sla }}
sla: {{ .Values.sla }}
{{- end }}
{{- end }}

{{/*
Cloudwatch exporter prometheus job name
*/}}
{{- define "aws-rabbitmq-monitoring.cwExporterSvcName" -}}
{{- printf "%s-%s" .Release.Name "prometheus-cloudwatch-exporter" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

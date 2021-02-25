{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "elasticsearch-monitoring.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "elasticsearch-monitoring.fullname" -}}
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
{{- define "elasticsearch-monitoring.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "elasticsearch-monitoring.labels" -}}
app.kubernetes.io/name: {{ include "elasticsearch-monitoring.name" . }}
helm.sh/chart: {{ include "elasticsearch-monitoring.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "elasticsearch-monitoring.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "elasticsearch-monitoring.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Truncate names of the subchart-exporters
*/}}
{{- define "elasticsearch-monitoring.elasticsearchExporterName" -}}
{{- printf "%s-%s" .Release.Name "prometheus-elasticsearch-exporter" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "elasticsearch-monitoring.cloudwatchExporterName" -}}
{{- printf "%s-%s" .Release.Name "prometheus-cloudwatch-exporter" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

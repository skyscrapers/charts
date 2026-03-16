{{/*
Expand the name of the chart.
*/}}
{{- define "goldenapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "goldenapp.fullname" -}}
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
Chart label
*/}}
{{- define "goldenapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "goldenapp.labels" -}}
helm.sh/chart: {{ include "goldenapp.chart" . }}
{{ include "goldenapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "goldenapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "goldenapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ServiceAccount name
*/}}
{{- define "goldenapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "goldenapp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Inject security with per-container policy:
- enforced (default): defaults win (non-overridable baseline)
- privileged: apply privileged profile, then allow container-level tweaks
- passthrough: don't inject anything; use container.securityContext as-is
*/}}
{{- define "goldenapp.secureContainer" -}}
{{- $container := deepCopy (index . 0) -}}
{{- $ctx       := index . 1 -}}
{{- $mode      := default "enforced" $container.securityMode -}}

{{- if eq $mode "passthrough" }}
  {{- /* Don't touch securityContext at all */ -}}
  {{- toYaml $container }}
{{- else if eq $mode "privileged" }}
  {{- $priv := deepCopy $ctx.Values.securityProfiles.privileged | default dict -}}
  {{- /* Start from privileged, then let the container tweak (container wins) */ -}}
  {{- $merged := merge $priv ($container.securityContext | default dict) -}}
  {{- $_ := set $container "securityContext" $merged -}}
  {{- toYaml $container }}
{{- else }}
  {{- /* enforced (default): baseline wins (non-overridable) */ -}}
  {{- $base := deepCopy $ctx.Values.globalSecurityDefaults | default dict -}}
  {{- $merged := merge ($container.securityContext | default dict) $base -}}
  {{- $_ := set $container "securityContext" $merged -}}
  {{- toYaml $container }}
{{- end }}
{{- end }}

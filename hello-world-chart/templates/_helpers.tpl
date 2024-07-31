{{/*
Expand the name of the chart.
*/}}
{{- define "hello-world.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "hello-world.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "hello-world.labels" -}}
helm.sh/chart: {{ include "hello-world.chart" . }}
{{ include "hello-world.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "hello-world.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hello-world.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Chart information
*/}}
{{- define "hello-world.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{/*
Service Account name
*/}}
{{- define "hello-world.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "hello-world.fullname" .) .Values.serviceAccount.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
""
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "multipaper-helm.name" -}}
{{- default .Chart.Name .Values.global.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "multipaper-helm.fullname" -}}
{{- if .Values.global.nameOverride }}
{{- .Values.global.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.global.nameOverride }}
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
{{- define "multipaper-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Computate service account name from values file or fullname.
*/}}
{{- define "multipaper-helm.serviceAccount.name" -}}
{{- if .Values.global.serviceAccount.name -}}
    {{ .Values.global.serviceAccount.name }}
{{- else -}}
    {{ include "multipaper-helm.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Common labels master
*/}}
{{- define "multipaper-helm.master.labels" -}}
helm.sh/chart: {{ include "multipaper-helm.chart" . }}
{{ include "multipaper-helm.master.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels master
*/}}
{{- define "multipaper-helm.master.selectorLabels" -}}
app.kubernetes.io/name: {{ include "multipaper-helm.name" . }}-master
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels server
*/}}
{{- define "multipaper-helm.server.labels" -}}
helm.sh/chart: {{ include "multipaper-helm.chart" . }}
{{ include "multipaper-helm.server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels server
*/}}
{{- define "multipaper-helm.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "multipaper-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
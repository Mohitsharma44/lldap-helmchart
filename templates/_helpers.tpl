{{/*
Expand the name of the chart.
*/}}
{{- define "lldap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lldap.fullname" -}}
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
{{- define "lldap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lldap.labels" -}}
helm.sh/chart: {{ include "lldap.chart" . }}
{{ include "lldap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lldap.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lldap.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lldap.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lldap.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the env vars to pass to lldap pod
*/}}
{{- define "lldap.env_vars" -}}
- name: UID
  value: {{ .Values.securityContext.runAsUser | default "1001" | quote }}
- name: GID
  value: {{ .Values.securityContext.runAsGroup | default "1001" | quote }}
- name: LLDAP_LDAP_PORT
  value: {{ .Values.lldap.ldap_port | default "3890" | quote }}
- name: LLDAP_HTTP_PORT
  value: {{ .Values.lldap.http_port | default "17170" | quote }}
- name: TZ
  value: {{ .Values.lldap.timezone | default "UTC" | quote }}
- name: LLDAP_LDAP_BASE_DN
  value: {{ .Values.lldap.base_dn | default "dc=example,dc=com" | quote }}
- name: LLDAP_JWT_SECRET
  valueFrom:
    secretKeyRef:
      name: lldap-secret
      key: lldap-jwt-secret
- name: LLDAP_LDAP_USER_PASS
  valueFrom:
    secretKeyRef:
      name: lldap-secret
      key: lldap-ldap-user-pass
{{- end }}

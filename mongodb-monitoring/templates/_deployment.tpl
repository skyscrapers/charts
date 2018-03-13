{{ define "mongodb_exporter_deployment" }}
{{- $port := default 5132 .publish_port }}
---
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: {{ .name }}
spec:
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: mongodb-exporter
    spec:
      containers:
        - name: mongodb-exporter
          command:
          - /usr/local/bin/mongodb_exporter
          - -web.listen-address
          - :{{ $port }}
          - -web.metrics-path
          - /metrics
          - -logtostderr
{{- if .groups_enabled }}
          - -groups.enabled
          - {{ .groups_enabled }}
{{- end }}
{{- if .mongodb_collect_collection }}
          - -mongodb.collect.collection {{ .mongodb_collect_collection }}
{{- end }}
{{- if .mongodb_collect_connpoolstats }}
          - -mongodb.collect.connpoolstats {{ .mongodb_collect_connpoolstats }}
{{- end }}
{{- if .mongodb_collect_database }}
          - -mongodb.collect.database {{ .mongodb.collect.database }}
{{- end }}
{{- if .mongodb_collect_oplog }}
          - -mongodb.collect.oplog {{ .mongodb_collect_oplog }}
{{- end }}
{{- if .mongodb_collect_profile }}
          - -mongodb.collect.profile {{ .mongodb_collect_profile }}
{{- end }}
{{- if .mongodb_collect_replset }}
          - -mongodb.collect.replset {{ .mongodb_collect_replset }}
{{- end }}
{{- if .mongodb_collect_top }}
          - -mongodb.collect.top {{ .mongodb_collect_top }}
{{- end }}
          - -mongodb.uri
          - {{ .mongodb_uri }}
          image: skyscrapers/mongodb-exporter:latest
          resources:
            limits:
              cpu: "0.1"
              memory: "100Mi"
          ports:
          - name: mongodb-metrics
            containerPort: {{ $port }}
            protocol: TCP
          livenessProbe:
              httpGet:
                port: {{ $port }}
                path: /metrics
              initialDelaySeconds: 30
              periodSeconds: 60
              timeoutSeconds: 5
          readinessProbe:
              httpGet:
                port: {{ $port }}
                path: /metrics
{{- end }}

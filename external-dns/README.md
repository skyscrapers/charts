---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: external-dns
spec:
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: external-dns
      annotations:
        iam.amazonaws.com/role: arn:aws:iam::847239549153:role/external_dns_controller
    spec:
      containers:
      - name: external-dns
        image: registry.opensource.zalan.do/teapot/external-dns:v0.3.0
        args:
          - --source=service
          - --source=ingress
          - --provider=aws
          - --registry=txt
          - --txt-owner-id=external-dns-controller

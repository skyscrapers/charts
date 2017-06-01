# Skyscrapers Helm charts

Our Kubernetes applications

## Bootstrap base charts

First you need to make a copy of `values.example.yaml` to `values.yaml` and edit all values accordingly, then you can just start installing:

```sh
helm install stable/kube2iam --values values.yaml
helm install stable/kube-lego --values values.yaml

helm repo add skyscrapers https://skyscrapers.github.io/charts
helm install skyscrapers/kubesignin --values values.yaml
# TODO helm install skyscrapers/nginx-ingress --values values.yaml
# TODO helm install skyscrapers/external-dns --values values.yaml
# TODO helm install skyscrapers/concourse --values values.yaml
```

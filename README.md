# Skyscrapers Helm charts

Our Kubernetes applications.

## Helm charts index

You can add this charts repo by:

```sh
helm repo add skyscrapers https://skyscrapers.github.io/charts
```

The actual Helm charts index is being hosted in GitHub pages in this same repo (`gh-pages` git branch). 
The charts and the charts index are automatically updated by Concourse when new commits arrive
on the master branch. see the [`ci`](https://github.com/skyscrapers/ci) repository for more details
on the setup.

## Bootstrap base charts

First you need to generate a `values.yaml` using the 
[`terraform-kubernetes/base`](https://github.com/skyscrapers/terraform-kubernetes/tree/master/base)
module, then you can just start installing:

```console
helm upgrade --install kube2iam skyscrapers/kube2iam --values helm-values.yaml
helm upgrade --install kube-lego skyscrapers/kube-lego --values helm-values.yaml
helm upgrade --install nginx-ingress skyscrapers/nginx-ingress --values helm-values.yaml
helm upgrade --install external-dns skyscrapers/external-dns --values helm-values.yaml
helm upgrade --install kubesignin skyscrapers/kubesignin --values helm-values.yaml
# TODO helm upgrade --install concourse-web skyscrapers/concourse --values values.yaml
helm upgrade --install prometheus-operator https://skyscrapers.github.io/charts/prometheus-operator-0.0.6-skyscrapers.1.tgz --namespace infrastructure --values helm-values.yaml
helm upgrade --install k8s-monitor skyscrapers/cluster-monitoring --namespace infrastructure --values helm-values.yaml 
```

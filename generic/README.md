# Deprecation notice

This chart is deprecated for Skyscrapers as we are migrating resources to native terraform objects.

# A Helm chart to deploy anything

This chart deploys any Kubernetes manifest provided in the `manifest` value.

Useful to deploy stuff via Terraform using the [Helm provider](https://github.com/terraform-providers/terraform-provider-helm). See [Examples](#examples) below.

**Note** that once the Kubernetes Terraform provider [supports generic resources](https://github.com/terraform-providers/terraform-provider-kubernetes/issues/215), this chart will loose its purpose.

## Installation

Install this in your cluster with [Helm](https://github.com/kubernetes/helm):
Get Helm [here](https://github.com/kubernetes/helm/blob/master/docs/install.md).

```shell
helm repo add skyscrapers https://skyscrapers.github.io/charts
```

```shell
helm install skyscrapers/generic
```

## Examples

Deploy [`cert-manager`](https://github.com/jetstack/cert-manager) and its CRDs via Terraform.

```tf
data "helm_repository" "skyscrapers" {
  name = "skyscrapers"
  url  = "https://skyscrapers.github.io/charts"
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

data "http" "cert_manager_crds" {
  url = "https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/00-crds.yaml"
}

resource "helm_release" "cert_manager_crds" {
  name       = "cert-manager-crds"
  repository = data.helm_repository.skyscrapers.metadata.0.name
  chart      = "generic"
  namespace  = "some-namespace"

  set {
    name  = "manifest"
    value = replace(data.http.cert_manager_crds.body, ",", "\\,")
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = data.helm_repository.stable.metadata.0.name
  chart      = "cert-manager"
  version    = "v0.6.7"
  namespace  = "some-namespace"

  values = [
    ...
  ]

  depends_on = [
    helm_release.cert_manager_crds
  ]
}
```

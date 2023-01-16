# Deprecation notice

This chart is deprecated for Skyscrapers as we are migrating resources to native terraform objects.

# A Helm Chart for basic setup of Helm

This charts creates a ServiceAccount used by Concourse to deploy helm charts with the right permissions.

## Installation

Install this in your cluster with [Helm](https://github.com/kubernetes/helm):
Get Helm [here](https://github.com/kubernetes/helm/blob/master/docs/install.md).

```shell
helm repo add skyscrapers https://skyscrapers.github.io/charts
```

```shell
helm install skyscrapers/helm-base
```

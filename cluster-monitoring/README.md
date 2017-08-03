# cluster-monitoring

A Helm master chart to install a k8s monitoring setup, based on [prometheus-operator](https://github.com/coreos/prometheus-operator) and [grafana](https://grafana.com/).

## TL;DR;

```console
$ helm install skyscrapers/cluster-monitoring -f values.yaml
```

## Introduction

Installs the following components for a complete k8s cluster monitoring setup:
-   [prometheus-operator](https://github.com/coreos/prometheus-operatortree/master/helm/prometheus-operator)
-   [kube-prometheus](https://github.com/coreos/prometheus-operator/tree/master/helm/kube-prometheus), which includes a Prometheus & Alertmanager TPR with some exporters for k8s cluster monitoring.
-   [grafana](https://github.com/coreos/prometheus-operator/tree/master/helm/grafana)

## Prerequisites
  - Kubernetes 1.6+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release skyscrapers/cluster-monitoring
```

The command deploys the complete k8s monitoring setup on the cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

As this chart itself doesn't provide any configurable parameters on it's own (yet), everything is taken over from upstream:
-   [prometheus-operator configuration](https://github.com/coreos/prometheus-operator/blob/master/helm/prometheus-operator/README.md#configuration)
-   [prometheus configuration](https://github.com/coreos/prometheus-operator/blob/master/helm/prometheus/README.md#configuration)
-   [alertmanager configuration](https://github.com/coreos/prometheus-operator/blob/master/helm/alertmanager/README.md#configuration)
-   [grafana configuration](https://github.com/coreos/prometheus-operator/blob/master/helm/grafana/README.md#configuration)

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set prometheus-operator.sendAnalytics=false \
    skyscrapers/cluster-monitoring
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml skyscrapers/cluster-monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Included subcharts

At this moment this chart also includes it's dependencies in the `charts/` directory, because we're using our own fork of the `prometheus` chart and the `grafana` chart hasn't been published yet.

Once [our changes](https://github.com/coreos/prometheus-operator/pull/515) are merged upstream, we can clean up these included dependencies.

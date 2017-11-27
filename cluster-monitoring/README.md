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
-   [opsgenie-heartbeat-proxy](https://github.com/traum-ferienwohnungen/opsgenie-heartbeat-proxy)

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

This charts only has configurable parameters for opsgenie-heartbeat-proxy, everything else is taken from upstream:

The following tables lists the configurable parameters of the prometheus-operator chart and their default values.

Parameter | Description | Default
--- | --- | ---
`opsgenieHeartbeatProxy.image` | Image | `traumfewo/opsgenie-heartbeat-proxy`
`opsgenieHeartbeatProxy.imageTag` | Image tag | `v0.0.2`
`opsgenieHeartbeatProxy.imagePullPolicy` | Image pull policy | `IfNotPresent`
`opsgenieHeartbeatProxy.port` | Port to run container on | `8080`
`opsgenieHeartbeatProxy.replicas` | Amount of replicas| `3`
`opsgenieHeartbeatProxy.imageTag` | Image tag | `v0.0.2`
`opsgenieHeartbeatProxy.opsgenie_api_key` | Opsgenie API Key | `""`
`opsgenieHeartbeatProxy.heartbeat_name` | Opsgenie Heartbeat name | `""`
`opsgenieHeartbeatProxy.resources` | Pod resource requests & limits | `CPU: 128m, Memory: 128Mi`

Upstream configuration can be found here:
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

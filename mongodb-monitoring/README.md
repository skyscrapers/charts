# mongodb-monitoring

A Helm chart for monitoring MongoDB via Prometheus and Grafana. This chart deploys the [mongodb-exporter](https://github.com/skyscrapers/mongodb_exporter) and configures Prometheus (via the [Operator](https://github.com/coreos/prometheus-operator)) for scraping the exposed metrics, sets up some alerts and Grafana dashboards.

## TL;DR

```shell
helm install skyscrapers/mongodb-monitoring -f values.yaml
```

## Prerequisites

- Kubernetes 1.6+
- [Prometheus Operator](https://github.com/coreos/prometheus-operator)

## Installing the Chart

To install the chart with the release name `my-release`:

```shell
helm install --name my-release skyscrapers/mongodb-monitoring
```

The command deploys the complete MongoDB monitoring setup on the cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

**Note**: You should deploy this chart in the same namespace as your Prometheus for the configuration to be automatically picked up.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```shell
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

This charts exposes a couple of configurable parameters, next to the ones from the upstream [mongodb-exporter](https://github.com/skyscrapers/mongodb_exporter).

The following tables lists the configurable parameters of mongodb-monitoring chart and their default values.

Parameter | Description | Default
--- | --- | ---
`prometheus.app` | Sets the `app` label value (ServiceMonitor & Alerting rules) | `prometheus`
`prometheus.name` | Sets the `prometheus` label value (ServiceMonitor & Alerting rules) | `k8s-monitor`
`prometheus.role` | Sets the `role` label value (Alerting rules) | `alert-rules`
`interval` | Interval for how often Prometheus scrapes the elasticsearch-exporter | `30s`

Upstream configuration can be found here:

- [mongodb-exporter](https://github.com/flant/charts/tree/master/prometheus/mongodb_exporter)

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```shell
helm install --name my-release -f my-values.yaml skyscrapers/mongodb-monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)


# Origin

https://github.com/flant/charts/tree/master/prometheus/mongodb_exporter

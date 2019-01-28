# mongodb-monitoring

A Helm chart for monitoring MongoDB via Prometheus and Grafana. This chart configures Prometheus (via the [Operator](https://github.com/coreos/prometheus-operator)) for scraping the exposed metrics, sets up some alerts and Grafana dashboards.

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

The command configures Prometheus to scrape mongo nodes in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

**Note**: You should deploy this chart in the same namespace as your Prometheus for the configuration to be automatically picked up.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```shell
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

This charts scrapes mongodb nodes to collect data and push it to prometheus. By default the only parameter is a list of IPs to scrape.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```shell
helm install --name my-release -f my-values.yaml skyscrapers/mongodb-monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)


# Origin


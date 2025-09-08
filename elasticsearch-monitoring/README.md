> [!IMPORTANT]
> **DEPRECATION NOTICE**: This chart is deprecated and will no longer be maintained.

# es-monitoring

A Helm chart for monitoring Elasticsearch via Prometheus and Grafana. This chart deploys the [elasticsearch-exporter](https://github.com/justwatchcom/elasticsearch_exporter) and configures Prometheus (via the [Operator](https://github.com/coreos/prometheus-operator)) for scraping the exposed metrics, sets up some alerts and Grafana dashboards.

## TL;DR

```shell
helm install skyscrapers/elasticsearch-monitoring -f values.yaml
```

## Prerequisites

- Kubernetes 1.6+
- [Prometheus Operator](https://github.com/coreos/prometheus-operator)

## Installing the Chart

To install the chart with the release name `my-release`:

```shell
helm install --name my-release skyscrapers/elasticsearch-monitoring
```

The command deploys the complete Elasticsearch monitoring setup on the cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

**Note**: You should deploy this chart in the same namespace as your Prometheus for the configuration to be automatically picked up.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```shell
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

This charts exposes a couple of configurable parameters, next to the ones from the upstream [elasticsearch-exporter](https://github.com/justwatchcom/elasticsearch_exporter).

The following tables lists the configurable parameters of elasticsearch-monitoring chart and their default values.

Parameter | Description | Default
--- | --- | ---
`prometheus.app` | Sets the `app` label value (ServiceMonitor & Alerting rules) | `prometheus`
`prometheus.name` | Sets the `prometheus` label value (ServiceMonitor & Alerting rules) | `cluster-monitoring`
`prometheus.role` | Sets the `role` label value (Alerting rules) | `alert-rules`
`esExporterScrapeInterval` | Interval for how often Prometheus scrapes the elasticsearch-exporter | `60s`
`esExporterScrapeTimeout` | Tiemout for the elasticsearch-exporter Prometheus scraper | `30s`
`amazonService.enabled` | Whether we're monitoring an Amazon Elasticsearch Service domain. Enabling this will get disk statistics from Cloudwatch instead of Elasticsearch directly | `false`
`amazonService.interval` | Interval for how often Prometheus scrapes the prometheus-cloudwatch-exporter | `600s`

Upstream configuration can be found here:

- [elasticsearch-exporter](https://github.com/kubernetes/charts/blob/master/stable/elasticsearch-exporter/README.md#configuration)
- [prometheus-cloudwatch-exporter](https://github.com/kubernetes/charts/tree/master/stable/prometheus-cloudwatch-exporter/README.md#configuration)

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```shell
helm install --name my-release \
  --set elasticsearch-exporter.es.uri=https://myremotees:443 \
    skyscrapers/elasticsearch-monitoring
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```shell
helm install --name my-release -f my-values.yaml skyscrapers/elasticsearch-monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)

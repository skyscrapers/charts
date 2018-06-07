# cloudwatch-monitoring

A Helm chart for monitoring cloudwatch via Prometheus and Grafana. This chart deploys the [cloudwatch-exporter](http://github.com/prometheus/cloudwatch_exporter) and configures Prometheus (via the [Operator](https://github.com/coreos/prometheus-operator)) for scraping the exposed metrics, sets up some alerts and Grafana dashboards (todo).

## TL;DR

```shell
helm install skyscrapers/cloudwatch-monitoring -f values.yaml
```

The command deploys the complete cloudwatch monitoring setup on the cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

**Note**: You should deploy this chart in the same namespace as your Prometheus for the configuration to be automatically picked up.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```shell
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

This charts exposes a couple of configurable parameters, next to the ones from the upstream [cloudwatch-exporter](https://github.com/kubernetes/charts/tree/master/stable/prometheus-cloudwatch-exporter).

The following tables lists the configurable parameters of cloudwatch-monitoring chart and their default values.

Parameter | Description | Default
--- | --- | ---
`prometheus.app` | Sets the `app` label value (ServiceMonitor & Alerting rules) | `prometheus`
`prometheus.name` | Sets the `prometheus` label value (ServiceMonitor & Alerting rules) | `k8s-monitor`
`prometheus.role` | Sets the `role` label value (Alerting rules) | `alert-rules`
`interval` | Interval for how often Prometheus scrapes the cloudwatch-exporter | `30s`

Upstream configuration can be found here:

- [cloudwatch-exporter](https://github.com/kubernetes/charts/tree/master/stable/prometheus-cloudwatch-exporter/README.md)

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```shell
helm install --name my-release \
  --set --set prometheus-cloudwatch-exporter.aws.role=arn:aws:iam::1234567890:role/kube2iam/cloudwatch_role \
    skyscrapers/cloudwatch-monitoring
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```shell
helm install --name my-release -f my-values.yaml skyscrapers/cloudwatch-monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)

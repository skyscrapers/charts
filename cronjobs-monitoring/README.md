# cronjobs-monitoring

A Helm chart for monitoring cronjobs status via Prometheus and AlertManager. This chart  configures Prometheus (via the [Operator](https://github.com/coreos/prometheus-operator)) for using the metrics from [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics), sets up an alert for when a job does not succeed.

## TL;DR

```shell
helm install skyscrapers/cronjobs-monitoring -f values.yaml
```

The command deploys the Prometheus rules of cronjobs monitoring setup on the cluster in the default configuration.

> **Tip**: List all releases using `helm list`

**Note**: You should deploy this chart in the same namespace as your Prometheus for the configuration to be automatically picked up.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```shell
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
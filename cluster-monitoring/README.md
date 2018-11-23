# cluster-monitoring

A Helm master chart to install a k8s monitoring setup, based on [prometheus-operator](https://github.com/coreos/prometheus-operator) and [grafana](https://grafana.com/).

## TL;DR

```sh
helm install skyscrapers/cluster-monitoring -f values.yaml
```

## Introduction

Installs the following components for a complete k8s cluster monitoring setup:

- [prometheus-operator](https://github.com/helm/charts/tree/master/stable/prometheus-operator)
- [opsgenie-heartbeat-proxy](https://github.com/traum-ferienwohnungen/opsgenie-heartbeat-proxy)

## Prerequisites

- Kubernetes 1.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```sh
helm install --name my-release skyscrapers/cluster-monitoring
```

The command deploys the complete k8s monitoring setup on the cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```sh
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

This charts only has configurable parameters for opsgenie-heartbeat-proxy, everything else is taken from upstream:

The following tables lists the configurable parameters of the prometheus-operator chart and their default values.

| Parameter                                 | Description                                                                                                                                                                                                                                                              | Default                              |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------ |
| `defaultDashboards`                       | Whether to include the default Grafana dashboards (found in `./dashboards-default`)                                                                                                                                                                                      | `true`                               |
| `extraDashboards`                         | Extra dashboard files to include (found in `./dashboards-extra`)                                                                                                                                                                                                         | `[]`                                 |
| `createMonitoringNamespace`               | Whether to create an "application-monitoring" namespace where you can add additional PrometheusRules and/or ServiceMonitors. This namespace will have a `prometheus` label, which can be used with Prometheus' ruleNamespaceSelector and serviceMonitorNamespaceSelector | `false`                              |
| `opsgenieHeartbeatProxy.image`            | Image                                                                                                                                                                                                                                                                    | `traumfewo/opsgenie-heartbeat-proxy` |
| `opsgenieHeartbeatProxy.imageTag`         | Image tag                                                                                                                                                                                                                                                                | `v0.0.2`                             |
| `opsgenieHeartbeatProxy.imagePullPolicy`  | Image pull policy                                                                                                                                                                                                                                                        | `IfNotPresent`                       |
| `opsgenieHeartbeatProxy.port`             | Port to run container on                                                                                                                                                                                                                                                 | `8080`                               |
| `opsgenieHeartbeatProxy.replicas`         | Amount of replicas                                                                                                                                                                                                                                                       | `3`                                  |
| `opsgenieHeartbeatProxy.imageTag`         | Image tag                                                                                                                                                                                                                                                                | `v0.0.2`                             |
| `opsgenieHeartbeatProxy.opsgenie_api_key` | Opsgenie API Key                                                                                                                                                                                                                                                         | `""`                                 |
| `opsgenieHeartbeatProxy.heartbeat_name`   | Opsgenie Heartbeat name                                                                                                                                                                                                                                                  | `""`                                 |
| `opsgenieHeartbeatProxy.resources`        | Pod resource requests & limits                                                                                                                                                                                                                                           | `CPU: 128m, Memory: 128Mi`           |

Upstream configuration can be found here:

- [prometheus-operator configuration](https://github.com/helm/charts/tree/master/stable/prometheus-operator#configuration)

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```sh
helm install --name my-release \
  --set defaultDashboards=false \
    skyscrapers/cluster-monitoring
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```sh
helm install --name my-release -f values.yaml skyscrapers/cluster-monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Migrate from older versions to 1.0.0

With version `1.0.0` of this chart we move from using an old [`kube-prometheus`](https://github.com/coreos/prometheus-operator/tree/master/helm) version to the new [`prometheus-operator`](https://github.com/helm/charts/tree/master/stable/prometheus-operator) chart as dependency. This is a breaking change and an upgrade from previous versions is not possible. You need to remove everything before deploying the new version:

```sh
helm delete --purge prometheus-operator
helm delete --purge k8s-monitor

# Remove the `kubelet` svc created by prometheus-operator
kubectl delete svc -n kube-system kubelet

# Remove CRDs or helm will fail
# WARNING: this will also remove all your Prometheuses, AlertManagers,
# ServiceMonitors and PrometheusRules created via the CRD!
# You will need to redeploy these after deploying the chart.
# Instead of removing the CRDs, you can also set the following value:
# `prometheus-operator.prometheusOperator.createCustomResource: false`
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
```

After the `helm purge` there might still be some leftover resources to delete. You can find these by running `kubectl get all --all-namespaces -l release=<your helm release name>` and delete those resources. Don't forget to also check your ConfigMaps for any leftovers.

## Acknowledgements

### Grafana dashboard sources

Included Grafana dashboards are based of the following sources:

- [Elasticsearch](https://grafana.com/dashboards/4358)
- [K8s Autoscaler](https://grafana.com/dashboards/3831)
- [K8s Calico](https://grafana.com/dashboards/3244)
- [K8s Nginx Ingress](https://grafana.com/dashboards/6927) with [certificate expiry](https://grafana.com/dashboards/6927)
- [K8s Node Resource Requests](https://github.com/coreos/prometheus-operator/blob/master/helm/grafana/dashboards/kubernetes-resource-requests-dashboard.json)
- [Concourse](https://github.com/bosh-prometheus/prometheus-boshrelease/tree/master/jobs/grafana_dashboards/templates)
- [MongoDB](https://grafana.com/dashboards/2583)
- [AWS SQS](https://grafana.com/dashboards/584)
- [Webapp](https://grafana.com/dashboards/3816)

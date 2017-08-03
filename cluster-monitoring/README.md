# A helm master chart to install a cluster monitoring setup

Installs the following components for a complete k8s cluster monitoring setup:
-   [prometheus-operator](https://github.com/coreos/prometheus-operator)
-   [kube-prometheus](https://github.com/coreos/prometheus-operator/tree/master/helm/kube-prometheus), which includes a Prometheus & Alertmanager TPR with some exporters for k8s cluster monitoring
-   [grafana](https://github.com/coreos/prometheus-operator/tree/master/helm/grafana)

## TL;DR;

```console
$ helm install skyscrapers/cluster-monitoring -f values.yaml
```

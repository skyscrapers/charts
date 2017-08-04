# Skyscrapers Helm charts

Our Kubernetes applications.

## Bootstrap base charts

First you need to make a copy of `values.example.yaml` to `values.yaml` and edit all values accordingly, then you can just start installing:

```console
helm repo add skyscrapers https://skyscrapers.github.io/charts
helm install skyscrapers/kube2iam --values values.yaml
helm install skyscrapers/kube-lego --values values.yaml
helm install skyscrapers/kubesignin --values values.yaml
helm install skyscrapers/nginx-ingress --values values.yaml
helm install skyscrapers/external-dns --values values.yaml
# TODO helm install skyscrapers/concourse --values values.yaml
helm install skyscrapers/cluster-monitoring --values values.yaml --namespace infrastructure --name k8s-monitor
```

## Helm charts index

You can add this charts repo by:

```sh
helm repo add skyscrapers https://skyscrapers.github.io/charts
```

The actual Helm charts index is being hosted in GitHub pages in this same repo (`gh-pages` git branch). The charts and the charts index are automatically updated by Concourse, see the `ci` folder.
If you want to update it manually just run `make all` (make sure you have `helm` installed).

## TODO

Figure out what did we change in the `nginx-ingress` chart and create a PR in the upstream chart.

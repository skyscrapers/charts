# Skyscrapers Helm charts

Our Kubernetes applications.

You can add this charts repo by:

```sh
helm repo add skyscrapers https://skyscrapers.github.io/charts
helm repo update
```

The actual Helm charts index is being hosted on GitHub pages in this same repo (`gh-pages` git branch). The charts and the charts index are automatically updated by Concourse when new commits arrive on the master branch. See the [`ci`](https://github.com/skyscrapers/ci) repository for more details on the setup.

**Important**: The `cluster-monitoring` wrapper chart we used for deploying `kube-prometheus-stack` is no longer maintained. However, you can still install the old versions; they are still published in our repo.

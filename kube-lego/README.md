# kube-lego

TL;DR:
```
helm install stable/kube-lego \
  --set config.LEGO_EMAIL=hello@skyscrapers.eu \
  --set config.LEGO_URL=https://acme-v01.api.letsencrypt.org/directory \
  --set config.LEGO_URL=https://acme-v01.api.letsencrypt.org/directory

```


We use the upstream https://github.com/kubernetes/charts/tree/master/stable/kube-lego

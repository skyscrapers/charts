# A helm chart to install external-dns

Installs [external-dns](https://github.com/kubernetes-incubator/external-dns) to manage external DNS servers (AWS Route53, Google CloudDNS and others) for Kubernetes Ingresses and Services.

## TL;DR;

```console
$ helm install skyscrapers/external-dns -f values.yaml
```

## Introduction

This chart bootstraps a [external-dns](https://github.com/kubernetes-incubator/external-dns) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
  - Kubernetes 1.6+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install skyscrapers/external-dns --name my-release -f values.yaml
```

The command deploys external-dns on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the external-dns chart and their default values.

Parameter | Description | Default
--- | --- | ---
`ExternalDNS.IAMRoleARN` | The IAM Role ARN to use to manage Route53 | (required)

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install skyscrapers/external-dns --name my-release \
  --set=ExternalDNS.IAMRoleARN=arn:aws:iam::0123456789:role/external-dns-role
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install skyscrapers/external-dns --name my-release -f values.yaml
```

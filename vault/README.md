# Vault Helm Chart

This is a fork of the [official Helm chart v0.6.0](https://github.com/hashicorp/vault-helm/tree/v0.6.0) with one small change to fit our use case: allow setting of the `injector.externalVaultAddr` value **without** disabling the vault server deployment. We use a LetsEncrypt signed certificate for end-to-end TLS and thus need to override the Injector's `AGENT_INJECT_VAULT_ADDR` env var to point to the correct SNI host. When specifying this, via the `externalVaultAddr` Helm value, the upstream chart automatically disables the Vault server.

For full documentation on this Helm chart along with all the ways you can
use Vault with Kubernetes, please see the
[Vault and Kubernetes documentation](https://www.vaultproject.io/docs/platform/k8s/).

## Prerequisites

To use the charts here, [Helm](https://helm.sh/) must be configured for your
Kubernetes cluster. Setting up Kubernetes and Helm and is outside the scope of
this README. Please refer to the Kubernetes and Helm documentation.

The versions required are:

  * **Helm 3.0+** - This is the earliest version of Helm tested. It is possible
    it works with earlier versions but this chart is untested for those versions.
  * **Kubernetes 1.9+** - This is the earliest version of Kubernetes tested.
    It is possible that this chart works with earlier versions but it is
    untested. Other versions verified are Kubernetes 1.10, 1.11.

## Usage

To install the latest version of this chart, add the Hashicorp helm repository
and run `helm install`:

```console
$ helm repo add hashicorp https://helm.releases.hashicorp.com
"hashicorp" has been added to your repositories

$ helm install vault hashicorp/vault
```

Please see the many options supported in the `values.yaml` file. These are also
fully documented directly on the [Vault
website](https://www.vaultproject.io/docs/platform/k8s/helm) along with more
detailed installation instructions.

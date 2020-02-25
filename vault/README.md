# Vault Helm Chart

This is a fork of the [official Helm chart v0.3.3](https://github.com/hashicorp/vault-helm/tree/v0.3.3) with one small change to fit our use case: backport the inclusion of the `injector.externalVaultAddr` value from the v0.4.0 chart, **without** disabling the vault server deployment.

There are two reasonse for doing this:

- We use a LetsEncrypt signed certificate for end-to-end TLS and thus need to override the Injector's `AGENT_INJECT_VAULT_ADDR` env var to point to the correct SNI host. When specifying this, via the `externalVaultAddr` Helm value, the upstream chart automatically disables the Vault server.
- Our clusters and automation are not compatible with Helm v3 yet (requirement of vault chart v0.4.0).

# Helm chart for OpenVPN

This chart is in large taken over from [the upstream community chart for OpenVPN](https://github.com/helm/charts/tree/master/stable/openvpn), however with quite some changes:

- Uses a Statefulset instead of Deployment for OpenVPN and enable persistence by default
- Uses new Helm / K8s labeling conventions
- Adds support for nodeSelector, tolerations and affinity
- Updates the OpenVPN image
- Some updates to the OpenVPN config
- Updates to the certificate generation/revocation scripts

Some of the above changes are available in some way as PR to the upstream chart. Our own main difference is the use of a Statefulset (which makes more sense with PVs in any case).

## Usage

When all components of the OpenVPN chart have started, you can use the supplied scripts for generating or revoking new client configs.

To generate a new OpenVPN config, run:

```bash
./ovpn-generate-client.sh <my_client> <my_vpn_hostname> [<namespace>] [<release>]
```

**Note**: By default, `namespace = infrastructure` and `release = openvpn`.

This will place the `<my_new_client>.ovpn` file in your current directory, which you can distribute to the person this config is for.

To revoke an OpenVPN config:

```bash
./ovpn-revoke-client.sh <my_client> [<namespace>] [<release>]
```

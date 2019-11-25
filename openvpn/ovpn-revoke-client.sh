#!/usr/bin/env bash

if [ $# -ne 1 ]
then
  echo "Usage: $0 <CLIENT_NAME> [<NAMESPACE>] [<HELM_RELEASE>]"
  echo "Example: $0 example_user"
  exit
fi

KEY_NAME="$1"
NAMESPACE="${2:-infrastructure}"
HELM_RELEASE="${3:-openvpn}"
POD_NAME=$(kubectl get pods -n "${NAMESPACE}" -l "app.kubernetes.io/name=openvpn,app.kubernetes.io/instance=${HELM_RELEASE}" -o jsonpath='{.items[0].metadata.name}')
kubectl -n "${NAMESPACE}" exec -it "${POD_NAME}" /etc/openvpn/setup/revokeClientCert.sh "${KEY_NAME}"

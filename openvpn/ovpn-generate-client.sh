#!/usr/bin/env bash

if [ $# -ne 2 ]
then
  echo "Usage: $0 <CLIENT_NAME> <OVPN_HOST> [<NAMESPACE>] [<HELM_RELEASE>]"
  echo "Example: $0 example_user vpn.example.com"
  exit
fi

KEY_NAME="$1"
OVPN_HOST="$2"
NAMESPACE="${3:-infrastructure}"
HELM_RELEASE="${4:-openvpn}"
POD_NAME=$(kubectl get pods -n "${NAMESPACE}" -l "app.kubernetes.io/name=openvpn,app.kubernetes.io/instance=${HELM_RELEASE}" -o jsonpath='{.items[0].metadata.name}')
SERVICE_NAME=$(kubectl get svc -n "${NAMESPACE}" -l "app.kubernetes.io/name=openvpn,app.kubernetes.io/instance=${HELM_RELEASE}" -o jsonpath='{.items[0].metadata.name}')
kubectl -n "${NAMESPACE}" exec -it "${POD_NAME}" /etc/openvpn/setup/newClientCert.sh "${KEY_NAME}" "${OVPN_HOST}"
kubectl -n "${NAMESPACE}" exec -it "${POD_NAME}" cat "/etc/openvpn/certs/pki/configs/${KEY_NAME}.ovpn" > "${KEY_NAME}.ovpn"

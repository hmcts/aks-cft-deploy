#!/bin/bash
set -e

NAMESPACES=${1:-bootstrap/deployments/namespaces.yaml}
kubectl apply -f ${NAMESPACES}
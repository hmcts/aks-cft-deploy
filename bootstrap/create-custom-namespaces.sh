#!/bin/bash
set -e

NAMESPACES=${bootstrap/deployments/namespaces.yaml}
kubectl apply -f ${NAMESPACES}
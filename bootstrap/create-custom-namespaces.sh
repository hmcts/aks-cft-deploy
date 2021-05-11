#!/bin/bash
set -e

NAMESPACES=(deployments/namespaces.yaml)
kubectl apply -f $NAMESPACES
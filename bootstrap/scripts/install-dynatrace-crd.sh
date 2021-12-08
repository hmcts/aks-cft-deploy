#!/bin/bash
set -ex

DYNATRACE_CRD=https://github.com/Dynatrace/dynatrace-operator/releases/download/v0.2.2/dynatrace.com_dynakubes.yaml

# Install Dynakube CRD for Dynatrace Operator
    kubectl apply -f ${DYNATRACE_CRD}

#!/bin/bash
set -ex

ENV=$3
CLUSTER_NAME=$6
FLUX_CONFIG_URL=https://raw.githubusercontent.com/hmcts/cnp-flux-config/asoraw
AGENT_BUILDDIRECTORY=/tmp
KUSTOMIZE_VERSION=4.5.7
TMP_DIR=/tmp/sbox
(
cat <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/hmcts/cnp-flux-config//apps/azureserviceoperator-system/cert-manager/?ref=asoraw
  - https://github.com/hmcts/cnp-flux-config//apps/azureserviceoperator-system/aso/?ref=asoraw
  - https://raw.githubusercontent.com/hmcts/cnp-flux-config/asoraw/apps/azureserviceoperator-system/sbox/base/aso-controller-settings.yaml
EOF
) > "${TMP_DIR}/kustomization.yaml"
# -----------------------------------------------------------
./kustomize build ${TMP_DIR} > "${TMP_DIR}/result.yaml"

#retries so that CRDs apply first and then manifests
for i in {1..3}; do
  (kubectl apply -f ${TMP_DIR}/result.yaml && break) || sleep 15;
done

rm -rf kustomize

#!/bin/bash
set -ex

ENV=$3
CLUSTER_NAME=$6
FLUX_CONFIG_URL=https://raw.githubusercontent.com/hmcts/cnp-flux-config/master

# Change $ENV var to correct name
if [ $ENV = "ptlsbox" ]; then
ENV="sbox-intsvc"
fi

# Install Flux
kubectl apply -f ${FLUX_CONFIG_URL}/apps/flux-system/base/gotk-components.yaml

#Git credentials
kubectl apply -f ${FLUX_CONFIG_URL}/apps/flux-system/${ENV}/base/git-credentials.yaml

#Create Flux Sync CRDs
kubectl apply -f ${FLUX_CONFIG_URL}/apps/flux-system/base/flux-config-gitrepo.yaml

#Install kustomize
curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
TMP_DIR=/tmp/flux/${ENV}/${CLUSTER_NAME}
mkdir -p $TMP_DIR
# -----------------------------------------------------------
(
cat <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: flux-system
resources:
  - ${FLUX_CONFIG_URL}/apps/flux-system/base/kustomize.yaml
patchesStrategicMerge:
  - ${FLUX_CONFIG_URL}/apps/flux-system/${ENV}/${CLUSTER_NAME}/kustomize.yaml
EOF
) > "${TMP_DIR}/kustomization.yaml"
# -----------------------------------------------------------

./kustomize build ${TMP_DIR} |  kubectl apply -f -


# ------------------------Flux V2----------------------------
# FLUX_CONFIG_URL=https://raw.githubusercontent.com/hmcts/cnp-flux-config/master

# if [ ${ENV} == "mgmt-sandbox" ]; then
#   CLUSTER_ENV="sbox-intsvc"
# elif [ ${ENV} == "cftptl" ]; then
#   CLUSTER_ENV="ptl-intsvc"
# else 
#   CLUSTER_ENV=${ENV}
# fi

# CLUSTER_NAME=$(echo ${CLUSTER_NAME} | cut -d'-' -f 2)

# # Install Flux
# kubectl apply -f ${FLUX_CONFIG_URL}/apps/flux-system/base/gotk-components.yaml

# #Git credentials
# kubectl apply -f ${FLUX_CONFIG_URL}/apps/flux-system/${CLUSTER_ENV}/base/git-credentials.yaml

# #Create Flux Sync CRDs
# kubectl apply -f ${FLUX_CONFIG_URL}/apps/flux-system/base/flux-config-gitrepo.yaml

# TMP_DIR=/tmp/flux/${CLUSTER_ENV}/${CLUSTER_NAME}
# mkdir -p $TMP_DIR
# # -----------------------------------------------------------
# (
# cat <<EOF
# apiVersion: kustomize.config.k8s.io/v1beta1
# kind: Kustomization
# namespace: flux-system
# resources:
#     - ${FLUX_CONFIG_URL}/apps/flux-system/base/kustomize.yaml
# patchesStrategicMerge:
#   - ${FLUX_CONFIG_URL}/apps/flux-system/${CLUSTER_ENV}/${CLUSTER_NAME}/kustomize.yaml
# EOF
# ) > "${TMP_DIR}/kustomization.yaml"
# # -----------------------------------------------------------

# ./kustomize build ${TMP_DIR} |  kubectl apply -f -

rm -rf kustomize

#!/bin/bash
set -ex

ENV=$3
CLUSTER_NAME=$6
FLUX_CONFIG_URL=https://raw.githubusercontent.com/hmcts/cnp-flux-config/master

############################################################
# Functions
############################################################
function create_admin_namespace {
    if kubectl get ns | grep -q admin; then
        echo "already exists - continuing"
    else
        kubectl create ns admin
    fi
}

function pod_identity_components {
    echo "Deploying AAD Pod Identity"
    mkdir -p "${TMP_DIR}/admin"

(
cat <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
namespace: admin
kind: Kustomization
commonLabels:
  k8s-app: aad-pod-id
resources:
  - https://raw.githubusercontent.com/Azure/aad-pod-identity/v1.8.6/deploy/infra/deployment-rbac.yaml
patchesStrategicMerge:
  - https://raw.githubusercontent.com/hmcts/cnp-flux-config/master/apps/admin/aad-pod-id/aad-pod-id-patch.yaml
EOF
) > "${TMP_DIR}/admin/kustomization.yaml"

# -----------------------------------------------------------

    ./kustomize build "${TMP_DIR}/admin" |  kubectl apply -f -
    
    CRDS="azureassignedidentities.aadpodidentity.k8s.io azureidentitybindings.aadpodidentity.k8s.io azureidentities.aadpodidentity.k8s.io azurepodidentityexceptions.aadpodidentity.k8s.io"
    for crd in $(echo "${CRDS}"); do
        kubectl -n flux-system wait --for condition=established --timeout=60s "customresourcedefinition.apiextensions.k8s.io/$crd"
    done
    
    kubectl apply -f https://raw.githubusercontent.com/hmcts/cnp-flux-config/master/apps/admin/aad-pod-id/mic-exception.yaml
    kubectl apply -f https://raw.githubusercontent.com/hmcts/cnp-flux-config/master/apps/kube-system/aad-pod-id/mic-exception.yaml

}

function flux_v2_installation {
    FLUX_CONFIG_URL=https://raw.githubusercontent.com/hmcts/cnp-flux-config/master
     mkdir -p "${TMP_DIR}/gotk"

# Deploy components and CRDs
(
cat <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: flux-system
resources:
  - ${FLUX_CONFIG_URL}/apps/flux-system/base/gotk-components.yaml
  - ${FLUX_CONFIG_URL}/apps/flux-system/${CLUSTER_ENV}/base/git-credentials.yaml
  - ${FLUX_CONFIG_URL}/apps/flux-system/${CLUSTER_ENV}/base/aks-sops-aadpodidentity.yaml
  - ${FLUX_CONFIG_URL}/apps/flux-system/base/flux-config-gitrepo.yaml
# patchesStrategicMerge:
# - ${FLUX_CONFIG_URL}/apps/flux-system/base/patches/kustomize-controller-patch.yaml
EOF
) > "${TMP_DIR}/gotk/kustomization.yaml"
# -----------------------------------------------------------
    ./kustomize build "${TMP_DIR}/gotk" |  kubectl apply -f -

    # Wait for CRDs to be in an established state
    kubectl -n flux-system wait --for condition=established --timeout=60s customresourcedefinition.apiextensions.k8s.io/gitrepositories.source.toolkit.fluxcd.io
    kubectl -n flux-system wait --for condition=established --timeout=60s customresourcedefinition.apiextensions.k8s.io/kustomizations.kustomize.toolkit.fluxcd.io
# -----------------------------------------------------------


############################################################
# End_of_Functions
############################################################

#Install kustomize
curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

if [ ${ENV} == "ptlsbox" ]; then
  CLUSTER_ENV="sbox-intsvc"
elif [ ${ENV} == "ptl" ]; then
  CLUSTER_ENV="ptl-intsvc"
else
  CLUSTER_ENV=${ENV}
fi

CLUSTER_NAME=$(echo ${CLUSTER_NAME} | cut -d'-' -f 2)
TMP_DIR=/tmp/flux/${CLUSTER_ENV}/${CLUSTER_NAME}
mkdir -p ${TMP_DIR}

# Create admin namespace
create_admin_namespace

# Deploy AAD Pod Identity
pod_identity_components

# Install Flux
flux_v2_installation

# -----------------------------------------------------------
(
cat <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: flux-system
resources:
  - ${FLUX_CONFIG_URL}/apps/flux-system/base/kustomize.yaml
patchesStrategicMerge:
  - ${FLUX_CONFIG_URL}/apps/flux-system/${CLUSTER_ENV}/${CLUSTER_NAME}/kustomize.yaml
EOF
) > "${TMP_DIR}/kustomization.yaml"
# -----------------------------------------------------------

./kustomize build ${TMP_DIR} |  kubectl apply -f -

rm -rf kustomize

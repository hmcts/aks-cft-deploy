#!/bin/bash
set -ex

ENV=$3
CLUSTER_NAME=$6
FLUX_CONFIG_URL=https://raw.githubusercontent.com/hmcts/cnp-flux-config/asoraw
AGENT_BUILDDIRECTORY=/tmp
KUSTOMIZE_VERSION=4.5.7

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
patches:
  - path: https://raw.githubusercontent.com/hmcts/cnp-flux-config/master/apps/admin/aad-pod-id/nmi-patch.yaml
  - path: https://raw.githubusercontent.com/hmcts/cnp-flux-config/master/apps/admin/aad-pod-id/mic-patch.yaml
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
    FLUX_CONFIG_URL=https://raw.githubusercontent.com/hmcts/cnp-flux-config/asoraw
     mkdir -p "${TMP_DIR}/gotk"

# Deploy components and CRDs
(
cat <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: flux-system
resources:
  - ${FLUX_CONFIG_URL}/apps/flux-system/base/gotk-components.yaml
  - git-credentials.yaml
  - ${FLUX_CONFIG_URL}/apps/flux-system/${CLUSTER_ENV}/base/aks-sops-aadpodidentity.yaml
patchesStrategicMerge:
  - ${FLUX_CONFIG_URL}/apps/flux-system/base/patches/kustomize-controller-patch.yaml
EOF
) > "${TMP_DIR}/gotk/kustomization.yaml"
# -----------------------------------------------------------
    ./kustomize build "${TMP_DIR}/gotk" |  kubectl apply -f -

    # Wait for CRDs to be in an established state
    kubectl -n flux-system wait --for condition=established --timeout=60s customresourcedefinition.apiextensions.k8s.io/gitrepositories.source.toolkit.fluxcd.io
    kubectl -n flux-system wait --for condition=established --timeout=60s customresourcedefinition.apiextensions.k8s.io/kustomizations.kustomize.toolkit.fluxcd.io
# -----------------------------------------------------------
}
function flux_ssh_git_key {
    echo " Kubectl Create Secret"
    kubectl create secret generic flux-git-deploy \
    --from-file=identity=$AGENT_BUILDDIRECTORY/flux-ssh-git-key \
    --namespace admin \
    --dry-run=client -o yaml | kubectl apply -f -
}

function flux_v2_ssh_git_key {
    ssh-keyscan -t ecdsa-sha2-nistp256 github.com > $AGENT_BUILDDIRECTORY/known_hosts
    echo " Kubectl Create Secret"
    kubectl create secret generic git-credentials \
    --from-file=identity=$AGENT_BUILDDIRECTORY/flux-ssh-git-key \
    --from-file=identity.pub=$AGENT_BUILDDIRECTORY/flux-ssh-git-key.pub \
    --from-file=known_hosts=$AGENT_BUILDDIRECTORY/known_hosts \
    --namespace flux-system \
    --dry-run=client -o yaml > "${TMP_DIR}/gotk/git-credentials.yaml"
}

############################################################
# End_of_Functions
############################################################

#Install kustomize

if [ -f ./kustomize ]; then
    echo "Kustomize installed"
else
    #Install kustomize
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash -s ${KUSTOMIZE_VERSION}
fi

if [ ${ENV} == "ptlsbox" ]; then
  CLUSTER_ENV="sbox-intsvc"
elif [ ${ENV} == "ptl" ]; then
  CLUSTER_ENV="ptl-intsvc"
else
  CLUSTER_ENV=${ENV}
fi

CLUSTER_NAME=$(echo ${CLUSTER_NAME} | cut -d'-' -f 2)
TMP_DIR=/tmp/flux/${CLUSTER_ENV}/${CLUSTER_NAME}
mkdir -p ${TMP_DIR}/gotk

# Create admin namespace
create_admin_namespace

#  Create secret in admin namespace
flux_ssh_git_key

# Deploy AAD Pod Identity
pod_identity_components

# Create a secret manifest containing git credentials
flux_v2_ssh_git_key

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
  - ${FLUX_CONFIG_URL}/apps/flux-system/base/flux-config-gitrepo.yaml
patchesStrategicMerge:
  - ${FLUX_CONFIG_URL}/apps/flux-system/${CLUSTER_ENV}/${CLUSTER_NAME}/kustomize.yaml
EOF
) > "${TMP_DIR}/kustomization.yaml"
# -----------------------------------------------------------

./kustomize build ${TMP_DIR} |  kubectl apply -f -

(
cat <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - https://github.com/hmcts/cnp-flux-config//apps/azureserviceoperator-system/cert-manager/?ref=asoraw
  - https://github.com/hmcts/cnp-flux-config//apps/azureserviceoperator-system/aso/?ref=asoraw
  #- https://raw.githubusercontent.com/hmcts/cnp-flux-config/asoraw/apps/azureserviceoperator-system/sbox/base/aso-controller-settings.yaml
EOF
) > "${TMP_DIR}/kustomization.yaml"
# -----------------------------------------------------------
./kustomize build ${TMP_DIR} |  kubectl apply -f -

rm -rf kustomize

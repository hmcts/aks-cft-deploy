#!/bin/bash
set -e

ENV=$1
CLUSTER=$2
ISSUER_URL=$3
REPO=$4

cd "$REPO"

# Update after ISSUER_URL: 
if [ -n "$ISSUER_URL" ]; then
    echo "Issuer URL is: ${ISSUER_URL}"
    #  Make file changes
    file_path="cnp-flux-config/apps/flux-system/$ENV/$CLUSTER/kustomize.yaml"
    pwd
    ls
    sed -i '' "s/ISSUER_URL:.*/ISSUER_URL: ${ISSUER_URL}_test/g" $file_path

    # Commit changes to github if there is any
    if [[ -n $(git status -s) ]]; then 
        git diff .
    fi
fi




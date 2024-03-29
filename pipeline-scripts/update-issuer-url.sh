#!/bin/bash
set -e

ENV=$1
CLUSTER=$2
ISSUER_URL=$3
REPO=$4
GIT_TOKEN=$5

cd "$REPO"

# Update after ISSUER_URL: 
if [ -n "$ISSUER_URL" ]; then
    echo "Issuer URL is: ${ISSUER_URL}"
    #  Make file changes
    ENV=$([[ "$ENV" == "ptl" ]] && echo "ptl-intsvc" || ([[ "$ENV" == "ptlsbox" ]] && echo "sbox-intsvc" || echo "$ENV" ))
    file_path="apps/flux-system/${ENV}/${CLUSTER}/kustomize.yaml"
    sed -i -e "s/ISSUER_URL:.*/ISSUER_URL: \"$(echo $ISSUER_URL | sed 's/[\/&]/\\&/g')\"/g" $file_path

    # Commit changes to github if there is any
    if [[ -n $(git status -s) ]]; then 
        git diff .
        git config --global user.email github-platform-operations@HMCTS.NET
        git config --global user.name "hmcts-platform-operations"
        git add .
        git commit -m "Updating OIDC Issuer URL for $CLUSTER cluster in $ENV"
        git remote set-url origin https://hmcts-platform-operations:"${GIT_TOKEN}"@github.com/hmcts/"$REPO".git
        git pull origin master --rebase
        for i in {1..5}; do
            git push --set-upstream origin HEAD:master && break || {
                echo "Failed to push, attempt $i of 5 - pulling remote again"
                git pull origin master --rebase
            }
        done
    else
        echo "No change to issuer URL, skipping git push..."
    fi
fi




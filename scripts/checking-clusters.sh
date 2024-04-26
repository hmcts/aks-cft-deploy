#!/bin/bash

cluster00="$(az aks list --output tsv --query '[].[name]' | grep 00 2>/dev/null)"
cluster01="$(az aks list --output tsv --query '[].[name]' | grep 01 2>/dev/null)"

if [[ -n $cluster00 && -n $cluster01 ]]; then 
    echo "Found multiple clusters"
    output="All"
elif [[ -n $cluster00 && ! -n $cluster01 ]]; then
    echo "Found 00 cluster only"
    output="00"
elif [[ ! -n $cluster00 && -n $cluster01 ]]; then
    echo "Found 01 cluster only"
    output="01"
else 
    echo "Found no clusters"
    output="None"
fi

echo "##vso[task.setvariable variable=cluster_deploy;isOutput=true]$output"
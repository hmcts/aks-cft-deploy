#!/bin/bash

# Check if both '00' and '01' clusters exist
if az aks list --query "[?contains(name, '${project}-${environment}-00-aks')]" &>/dev/null && \
   az aks list --query "[?contains(name, '${project}-${environment}-01-aks')]" &>/dev/null; then
    output="All"
elif az aks list --query "[?contains(name, ${project}-${environment}-00-aks')]" &>/dev/null; then
    output="00"
elif az aks list --query "[?contains(name, '${project}-${environment}-01-aks')]" &>/dev/null; then
    output="01"
else
    output="None"
fi

echo "##vso[task.setvariable variable=cluster_output]$output"
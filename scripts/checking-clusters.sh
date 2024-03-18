#!/bin/bash

# Check if both '00' and '01' clusters exist
if az aks list --query "[?contains(name, 'a-prod-00-cluster')]" &>/dev/null && \
   az aks list --query "[?contains(name, 'a-prod-01-cluster')]" &>/dev/null; then
    output="All"
elif az aks list --query "[?contains(name, 'a-prod-00-cluster')]" &>/dev/null; then
    output="00"
elif az aks list --query "[?contains(name, 'a-prod-01-cluster')]" &>/dev/null; then
    output="01"
else
    output="None"
fi
echo $output
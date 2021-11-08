#!/bin/bash

ENV=$1

if [ $ENV = "perftest" ]; then
ENV="test"
elif [ $ENV = "aat" ]; then
ENV="stg"
elif [ $ENV = "preview" ]; then
ENV="dev"
fi

STORAGE_ACCOUNT_NAME=cftapps$ENV
RESOURCE_GROUP_NAME=core-infra-$ENV-rg 


echo $STORAGE_ACCOUNT_NAME

echo $RESOURCE_GROUP_NAME
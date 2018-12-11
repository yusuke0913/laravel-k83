#!/bin/bash

. ../../../.env/env_main
. ../../../.env/env_ecr

kubectl describe configmap -n kube-system aws-auth

kubectl apply -f config_map_aws_auth_${APP_NAME}.yaml

kubectl describe configmap -n kube-system aws-auth



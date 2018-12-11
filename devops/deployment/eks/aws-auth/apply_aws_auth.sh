#!/bin/bash

. ../../env_common
. ../env_eks

kubectl describe configmap -n kube-system aws-auth

kubectl apply -f config_map_aws_auth_${PROJ_NAME}.yaml

kubectl describe configmap -n kube-system aws-auth



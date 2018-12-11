#!/bin/bash

. ../../env_common
. ../env_eks

kubectl apply -f eks-admin-service-account.yaml

kubectl apply -f eks-admin-cluster-role-binding.yaml


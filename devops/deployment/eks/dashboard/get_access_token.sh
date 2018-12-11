#!/bin/bash

. ../../env_common
. ../env_eks

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}') | grep token


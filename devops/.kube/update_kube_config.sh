#!/bin/bash

echo "copying kube config..."

CONFIG_DIR=~/.kube
CONFIG_FILE=config_eks_laravel-k83
cp $CONFIG_FILE $CONFIG_DIR
ls -l $CONFIG_DIR

echo "Updating KUBECONFIG"
echo "export KUBECONFIG=$CONFIG_DIR/$CONFIG_FILE"

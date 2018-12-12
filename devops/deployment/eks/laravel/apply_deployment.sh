#!/bin/bash



kubectl apply -f laravel-deployment.yaml
kubectl describe deployments laravel


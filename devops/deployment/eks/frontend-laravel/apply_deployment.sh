#!/bin/bash



kubectl apply -f frontend-laravel-deployment.yaml
kubectl describe deployments frontend-laravel


#!/bin/bash



kubectl apply -f laravel-deployment.yaml
kubectl describe deployments laravel

kubectl apply -f laravel-service.yaml
kubectl describe services laravel


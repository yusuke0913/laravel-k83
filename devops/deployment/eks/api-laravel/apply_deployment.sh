#!/bin/bash

kubectl apply -f api_laravel-deployment.yaml
kubectl describe deployments api-laravel


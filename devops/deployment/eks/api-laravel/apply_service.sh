#!/bin/bash

kubectl apply -f api-laravel-service.yaml
kubectl describe services api-laravel


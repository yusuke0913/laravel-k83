#!/bin/bash

kubectl apply -f frontend-laravel-service.yaml
kubectl describe services frontend-laravel


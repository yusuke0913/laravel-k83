#!/bin/bash

kubectl apply -f laravel-service.yaml
kubectl describe services laravel


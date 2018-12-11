#!/bin/bash



# kubectl apply -f frontend-deployment.yaml
# kubectl describe deployments frontend
kubectl apply -f frontend-pod.yaml
kubectl describe pods frontend
kubectl apply -f frontend-service.yaml
kubectl describe services frontend


#!/bin/bash

echo "deploying..."

# docker login
$(aws ecr get-login --no-include-email)

echo "updating ${IMG_FRONTEND_NGINX}..."
docker tag ${IMG_FRONTEND_NGINX}:latest ${ECR_REPOSITORY_FRONTEND_NGINX_URL}:latest
docker push ${ECR_REPOSITORY_FRONTEND_NGINX_URL}:latest

echo "updating ${IMG_FRONTEND_PHP}..."
docker tag ${IMG_FRONTEND_PHP}:latest ${ECR_REPOSITORY_FRONTEND_PHP_URL}:latest
docker push ${ECR_REPOSITORY_FRONTEND_PHP_URL}:latest

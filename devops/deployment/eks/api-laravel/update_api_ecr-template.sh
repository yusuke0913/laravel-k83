#!/bin/bash

echo "deploying..."

# docker login
$(aws ecr get-login --no-include-email)

echo "updating ${IMG_API_NGINX}..."
docker tag ${IMG_API_NGINX}:latest ${ECR_REPOSITORY_API_NGINX_URL}:latest
docker push ${ECR_REPOSITORY_API_NGINX_URL}:latest

echo "updating ${IMG_API_PHP}..."
docker tag ${IMG_API_PHP}:latest ${ECR_REPOSITORY_API_PHP_URL}:latest
docker push ${ECR_REPOSITORY_API_PHP_URL}:latest

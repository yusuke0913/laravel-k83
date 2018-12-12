#!/bin/bash

echo "deploying..."

# docker login
$(aws ecr get-login --no-include-email)

echo "updating ${IMG_NGINX}..."
docker tag ${IMG_NGINX}:latest ${ECR_REPOSITORY_NGINX_URL}:latest
docker push ${ECR_REPOSITORY_NGINX_URL}:latest

echo "updating ${IMG_PHP}..."
docker tag ${IMG_PHP}:latest ${ECR_REPOSITORY_PHP_URL}:latest
docker push ${ECR_REPOSITORY_PHP_URL}:latest

#!/bin/bash

echo "deploying..."

# docker login
$(aws ecr get-login --no-include-email)

echo "updating laravel-k83_api-nginx..."
docker tag laravel-k83_api-nginx:latest 185555976764.dkr.ecr.us-east-1.amazonaws.com/laravel-k83_api-nginx:latest
docker push 185555976764.dkr.ecr.us-east-1.amazonaws.com/laravel-k83_api-nginx:latest

echo "updating laravel-k83_api-php..."
docker tag laravel-k83_api-php:latest 185555976764.dkr.ecr.us-east-1.amazonaws.com/laravel-k83_api-php:latest
docker push 185555976764.dkr.ecr.us-east-1.amazonaws.com/laravel-k83_api-php:latest

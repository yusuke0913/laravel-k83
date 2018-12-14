#!/bin/bash

. ./devops/.env/env_main
echo "build ${APP_NAME} ..."

docker-compose --project-name ${APP_NAME} -f docker-compose.yaml build --no-cache

docker images | grep ^${APP_NAME}

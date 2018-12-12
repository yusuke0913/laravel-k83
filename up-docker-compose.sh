#!/bin/bash

. ./devops/.env/env_main
echo "build ${APP_NAME} ..."

docker-compose --project-name ${APP_NAME} up

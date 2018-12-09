#!/bin/bash

PROJ_NAME="laravel-k83"
echo "build ${PROJ_NAME} ..."
docker-compose --project-name ${PROJ_NAME} build

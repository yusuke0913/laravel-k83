#!/bin/bash

echo "deploying..."

cd `dirname $0`/../

PROJ_NAME="laravel-k83"

# docker login
$(aws ecr get-login --no-include-email)

for TARGET in nginx php
do
		echo $TARGET
		REPO_URL=`terraform output ecr_${TARGET}_url`
		IMG="${PROJ_NAME}_${TARGET}"
		# docker tag
		docker tag ${IMG}:latest ${REPO_URL}:latest
		docker push ${REPO_URL}:latest
done







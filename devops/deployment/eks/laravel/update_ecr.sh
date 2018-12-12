#!/bin/bash

echo "deploying..."

. ../../../.env/env_main
. ../../../.env/env_ecr


# docker login
$(aws ecr get-login --no-include-email)

for TARGET in nginx php
do
		echo "updating $TARGET..."
		TARGET_UPPER_CASE=`echo $TARGET | awk '{print toupper($0)}'`
		REPO_URL_VAR_NAME="ECR_REPOSITORY_${TARGET_UPPER_CASE}_URL"
		REPO_URL=`echo ${!REPO_URL_VAR_NAME}`
		IMG="${APP_NAME}_${TARGET}"
		echo $IMG $REPO_URL
		
		# docker tag
		docker tag ${IMG}:latest ${REPO_URL}:latest
		docker push ${REPO_URL}:latest
done







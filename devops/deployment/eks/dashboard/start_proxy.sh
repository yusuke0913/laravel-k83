#!/bin/bash

ps aux | grep 'kubectl proxy' | grep -v grep | awk '{ print $2 }' | xargs kill -9
kubectl proxy &
open http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy
./get_access_token.sh


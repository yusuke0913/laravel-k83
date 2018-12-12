#!/bin/bash

./deploy_dashboard.sh

./apply_eks_admin_service_account.sh

./get_access_token.sh

./start_proxy.sh

# DevOps
Set up EKS environment on AWS. You need to have your own AWS account and It will cost you.

## Installation

- Terraform

## Initialize eks

```
aws configure --profile terraform
```

```
terraform init
terraform plan
terraform apply
```

## Configure eks

### .kube config

After initilizing eks, config_eks_laravel-k83 will be generated inside .kube directory.
Export KUBECONFIG environment to use kube command.

```
cd .kube
./update_kube_config.sh

## output
export KUBECONFIG=/${YOUR_HOME_DIRECTORY}/.kube/config_laravel-k83

Execute the export command

# check your config and cluster-info
kubectl config view
kubectl cluster-info
```

### Configure aws-auth
```
cd deployment/eks/aws-auth
./apply_aws_auth.sh
```

### Deploy Dashboard Web UI

```
cd deployment/eks/dashboard
./init.sh
```

You can get your access token by executing get_access_token.sh and automatically copy the token on clipboard.
```
./get_access_token.sh
```

### Deploy api-laravel project

```


# aws-auth-setting

## Official Documents
[Managing Users or IAM Roles for your Cluster](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)

## kubeconfig

kubeconfig file is put inside the .kube dir. Please put the config into your local ~/.kube directory.
```
export KUBECONFIG=$KUBECONFIG:~/.kube/config-${PROJ_NAME}
```

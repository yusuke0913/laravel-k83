module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "${var.eks_cluster_name}"
  subnets      = ["${data.aws_subnet_ids.private.ids}"]

  tags = {
    Environment = "${var.env}"
  }

  vpc_id           = "${data.aws_vpc.main.id}"
  write_kubeconfig = false
  manage_aws_auth  = false
}

resource "local_file" "kubeconfig" {
  content  = "${module.eks.kubeconfig}"
  filename = "./.kube/config_eks_${var.app_name}"
}

resource "local_file" "config_map_aws_auth" {
  content  = "${module.eks.config_map_aws_auth}"
  filename = "./deployment/eks/aws-auth/config_map_aws_auth_${var.app_name}.yaml"
}

locals {
  deployment_config = <<DEPLOYMENT_CONFIG
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: laravel
  labels:
    app: laravel
spec:
  selector:
    matchLabels:
      app: laravel
      tier: frontend
  replicas: 3
  template:
    metadata:
      labels:
        app: laravel
        tier: frontend
    spec:
      volumes:
        - name: nginx-default-conf-volume
          configMap:
            name: nginx-default-conf
        - name: var-run-volume
          emptyDir: {}

      containers:
        - name: nginx
          image: ${aws_ecr_repository.nginx.repository_url}:latest
          resources:
            requests:
              cpu: 100m
              memory: 100Mi
          ports:
            - containerPort: 80
          volumeMounts:
            - name: var-run-volume
              mountPath: /var/run

        - name: php
          image: ${aws_ecr_repository.php.repository_url}:latest
          resources:
            requests:
              cpu: 100m
              memory: 100Mi
          volumeMounts:
            - name: var-run-volume
              mountPath: /var/run

  DEPLOYMENT_CONFIG
}

resource "local_file" "deployment_config" {
  content  = "${local.deployment_config}"
  filename = "./deployment/eks/laravel/laravel-deployment.yaml"
}

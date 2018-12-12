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

data "template_file" "laravel_deployment_config" {
  template = "${file("./deployment/eks/laravel/laravel-deployment-template.yaml")}"

  vars {
    ECR_REPOSITORY_NGINX_URL = "${aws_ecr_repository.nginx.repository_url}"
    ECR_REPOSITORY_PHP_URL   = "${aws_ecr_repository.php.repository_url}"
  }
}

resource "local_file" "laravel_deployment_config" {
  content  = "${data.template_file.laravel_deployment_config.rendered}"
  filename = "./deployment/eks/laravel/laravel-deployment.yaml"
}

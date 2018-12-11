module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "${var.eks_cluster_name}"

  #   subnets      = ["${aws.subnets.}", "subnet-bcde012a"]
  subnets = ["${data.aws_subnet_ids.private.ids}"]

  tags = {
    Environment = "${var.env}"
  }

  vpc_id = "${data.aws_vpc.main.id}"

  write_kubeconfig = false
  manage_aws_auth  = false
}

resource "local_file" "kubeconfig" {
  content  = "${module.eks.kubeconfig}"
  filename = "./.kube/config_${var.app_name}"
}

resource "local_file" "config_map_aws_auth" {
  content  = "${module.eks.config_map_aws_auth}"
  filename = "./deployment/eks/aws-auth/config_map_aws_auth_${var.app_name}.yaml"
}

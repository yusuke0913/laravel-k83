data "aws_vpc" "main" {
  id = "${module.vpc.vpc_id}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags {
    Tier = "Private"
  }
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "${var.app_name}-eks-cluster"

  #   subnets      = ["${aws.subnets.}", "subnet-bcde012a"]
  subnets = ["${data.aws_subnet_ids.private.ids}"]

  tags = {
    Environment = "${var.env}"
  }

  vpc_id = "${data.aws_vpc.main.id}"
}

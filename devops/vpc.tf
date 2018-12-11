module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.app_name}"

  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["${var.private_subnet_1_cidr}", "${var.private_subnet_2_cidr}", "${var.private_subnet_3_cidr}"]
  public_subnets  = ["${var.public_subnet_1_cidr}", "${var.public_subnet_2_cidr}", "${var.public_subnet_3_cidr}"]

  assign_generated_ipv6_cidr_block = true

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner       = "${var.aws_profile}"
    Environment = "${var.env}"
  }

  vpc_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }

  private_subnet_tags = {
    Tier                                            = "Private"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }

  public_subnet_tags = {
    Tier = "public"
  }

  vpc_tags = {
    Name = "${var.app_name}"
  }
}

data "aws_vpc" "main" {
  id = "${module.vpc.vpc_id}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags {
    Tier = "Private"
  }
}

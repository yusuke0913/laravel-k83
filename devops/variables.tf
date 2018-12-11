variable "aws_profile" {
  default = "terraform"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "laravel-k83"
}

variable "env" {
  default = "dev"
}

variable "private_subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_3_cidr" {
  default = "10.0.3.0/24"
}

variable "public_subnet_1_cidr" {
  default = "10.0.101.0/24"
}

variable "public_subnet_2_cidr" {
  default = "10.0.102.0/24"
}

variable "public_subnet_3_cidr" {
  default = "10.0.103.0/24"
}

variable "eks_cluster_name" {
  default = "laravel-k83-eks-cluster"
}

variable "env_dir" {
  default = "./.env"
}

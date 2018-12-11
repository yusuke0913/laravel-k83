resource "aws_ecr_repository" "php" {
  name = "${var.app_name}_php"
}

resource "aws_ecr_repository" "nginx" {
  name = "${var.app_name}_nginx"
}

locals {
  env_ecr = <<ENV
ECR_REPOSITORY_NGINX_URL=${aws_ecr_repository.nginx.repository_url}
ECR_REPOSITORY_PHP_URL=${aws_ecr_repository.php.repository_url}
  ENV
}

resource "local_file" "env_ecr" {
  content  = "${local.env_ecr}"
  filename = "${var.env_dir}/env_ecr"
}

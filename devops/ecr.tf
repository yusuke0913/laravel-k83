locals {
  nginx_repo_name = "${var.app_name}_nginx"
  php_repo_name   = "${var.app_name}_php"

  api_nginx_repo_name = "${var.app_name}_api-nginx"
  api_php_repo_name   = "${var.app_name}_api-php"
}

resource "aws_ecr_repository" "php" {
  name = "${local.php_repo_name}"
}

resource "aws_ecr_repository" "nginx" {
  name = "${local.nginx_repo_name}"
}

resource "aws_ecr_repository" "api_nginx" {
  name = "${local.api_nginx_repo_name}"
}

resource "aws_ecr_repository" "api_php" {
  name = "${local.api_php_repo_name}"
}

data "template_file" "update_ecr_sh" {
  template = "${file("./deployment/eks/laravel/update_ecr-template.sh")}"

  vars {
    IMG_NGINX                = "${local.nginx_repo_name}"
    IMG_PHP                  = "${local.php_repo_name}"
    ECR_REPOSITORY_NGINX_URL = "${aws_ecr_repository.nginx.repository_url}"
    ECR_REPOSITORY_PHP_URL   = "${aws_ecr_repository.php.repository_url}"
  }
}

resource "local_file" "update_ecr_sh" {
  content  = "${data.template_file.update_ecr_sh.rendered}"
  filename = "./deployment/eks/laravel/update_ecr.sh"
}

data "template_file" "update_api_ecr_sh" {
  template = "${file("./deployment/eks/api-laravel/update_api_ecr-template.sh")}"

  vars {
    IMG_API_NGINX                = "${local.api_nginx_repo_name}"
    IMG_API_PHP                  = "${local.api_php_repo_name}"
    ECR_REPOSITORY_API_NGINX_URL = "${aws_ecr_repository.api_nginx.repository_url}"
    ECR_REPOSITORY_API_PHP_URL   = "${aws_ecr_repository.api_php.repository_url}"
  }
}

resource "local_file" "update_api_ecr_sh" {
  content  = "${data.template_file.update_api_ecr_sh.rendered}"
  filename = "./deployment/eks/api-laravel/update_api_ecr.sh"
}

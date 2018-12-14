locals {
  frontend_nginx_repo_name = "${var.app_name}_frontend-nginx"
  frontend_php_repo_name   = "${var.app_name}_frontend-php"

  api_nginx_repo_name = "${var.app_name}_api-nginx"
  api_php_repo_name   = "${var.app_name}_api-php"
}

resource "aws_ecr_repository" "frontend_php" {
  name = "${local.frontend_php_repo_name}"
}

resource "aws_ecr_repository" "frontend_nginx" {
  name = "${local.frontend_nginx_repo_name}"
}

resource "aws_ecr_repository" "api_nginx" {
  name = "${local.api_nginx_repo_name}"
}

resource "aws_ecr_repository" "api_php" {
  name = "${local.api_php_repo_name}"
}

data "template_file" "update_frontend_laravel_ecr_sh" {
  template = "${file("./deployment/eks/frontend-laravel/template-update-frontend-laravel-ecr.sh")}"

  vars {
    IMG_FRONTEND_NGINX                = "${local.frontend_nginx_repo_name}"
    IMG_FRONTEND_PHP                  = "${local.frontend_php_repo_name}"
    ECR_REPOSITORY_FRONTEND_NGINX_URL = "${aws_ecr_repository.frontend_nginx.repository_url}"
    ECR_REPOSITORY_FRONTEND_PHP_URL   = "${aws_ecr_repository.frontend_php.repository_url}"
  }
}

resource "local_file" "update_frontend_laravel_ecr_sh" {
  content  = "${data.template_file.update_frontend_laravel_ecr_sh.rendered}"
  filename = "./deployment/eks/frontend-laravel/update_frontend_laravel_ecr.sh"
}

data "template_file" "update_api_laravel_ecr_sh" {
  template = "${file("./deployment/eks/api-laravel/template-update-api-laravel-ecr.sh")}"

  vars {
    IMG_API_NGINX                = "${local.api_nginx_repo_name}"
    IMG_API_PHP                  = "${local.api_php_repo_name}"
    ECR_REPOSITORY_API_NGINX_URL = "${aws_ecr_repository.api_nginx.repository_url}"
    ECR_REPOSITORY_API_PHP_URL   = "${aws_ecr_repository.api_php.repository_url}"
  }
}

resource "local_file" "update_api_laravel_ecr_sh" {
  content  = "${data.template_file.update_api_laravel_ecr_sh.rendered}"
  filename = "./deployment/eks/api-laravel/update_api_laravel_ecr_sh.sh"
}

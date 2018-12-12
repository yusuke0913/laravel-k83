locals {
  nginx_repo_name = "${var.app_name}_nginx"
  php_repo_name   = "${var.app_name}_php"
}

resource "aws_ecr_repository" "php" {
  name = "${local.php_repo_name}"
}

resource "aws_ecr_repository" "nginx" {
  name = "${local.nginx_repo_name}"
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

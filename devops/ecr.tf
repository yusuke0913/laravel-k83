resource "aws_ecr_repository" "php" {
  name = "${var.app_name}_php"
}

resource "aws_ecr_repository" "nginx" {
  name = "${var.app_name}_nginx"
}

output "ecr_php_url" {
  value = "${aws_ecr_repository.php.repository_url}"
}

output "ecr_nginx_url" {
  value = "${aws_ecr_repository.nginx.repository_url}"
}

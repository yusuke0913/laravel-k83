provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}

locals {
  env_main = <<ENV
  APP_NAME=${var.app_name}
  ENV
}

resource "local_file" "env_main" {
  content  = "${local.env_main}"
  filename = "${var.env_dir}/env_main"
}

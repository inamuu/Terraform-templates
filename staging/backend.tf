provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket                  = "${var.backend_bucket_name}"
    key                     = "terraform.tfstate"
    region                  = "${var.aws_region}"
    shared_credentials_file = "~/.aws/credentials"
    ### profile名は変数で定義してもこけるので直接記述する
    profile                 = "XXXXXXXXXXX"
  }
}

variable "aws_account_id" {
  default = "XXXXXXXXXXX"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "profile_name" {}

variable "aws_region" {
  default = "ap-northeast-1"
}

## CloudFront
variable "site_domain" {
  default = "inamuu-com"
}

variable "alias_site_domain" {
  default = ["www.inamuu.com"]
}

## ECS
variable "aws_ecs_service_desired_count_app" {
  default = 1
}

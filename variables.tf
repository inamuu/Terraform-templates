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

## CloudWatch Logs Group
variable "kinesis_s3_cloudwatch_logs_group" {
  default = [
    "/ecs/app",
    "/ecs/bastion"
  ]
}

## Kinesis Data Firehose Name
variable "kinesis_name_s3" {
  default = [
    "ecs_app",
    "ecs_bastion"
  ]
}

## IAM Role
variable "firehose_delivery_role" {
  default = "arn:aws:iam::XXXXXXXXXX:role/Firehose_Delivery_Role"
}

variable "kinesis_basic_role" {
  default = "arn:aws:iam::XXXXXXXXXX:role/Kinesis_Basic_Role"
}

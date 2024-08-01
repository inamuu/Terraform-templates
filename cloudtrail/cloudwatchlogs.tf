resource "aws_cloudwatch_log_group" "this" {
  name = local.cloudtrail_gmd_prefix
}

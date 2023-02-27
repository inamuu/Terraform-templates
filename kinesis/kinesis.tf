resource "aws_kinesis_firehose_delivery_stream" "firehose_s3" {
  name        = element(var.kinesis_name_s3, count.index)
  destination = "extended_s3"
  count       = length(var.kinesis_s3_cloudwatch_logs_group)

  extended_s3_configuration {
    role_arn            = var.firehose_delivery_role
    bucket_arn          = "arn:aws:s3:::${var.logs_bucket_name}"
    buffer_size         = 10
    buffer_interval     = 300
    prefix              = join("", [element(var.kinesis_s3_cloudwatch_logs_group, count.index), "/CloudWatchLogs/!{timestamp:yyyy/MM/dd}"])
    error_output_prefix = join("", [element(var.kinesis_s3_cloudwatch_logs_group, count.index), "/CloudWatchLogs/result=!{firehose:error-output-type}/!{timestamp:yyyy/MM/dd}"])
    cloudwatch_logging_options {
      enabled = true
      log_group_name = element(var.kinesis_s3_cloudwatch_logs_group, count.index)
      log_stream_name = "*"
    }
  }
}

resource "aws_cloudwatch_log_subscription_filter" "forward_cloudwatchlogs_to_s3" {
  name            = "forward_cloudwatchlogs_to_s3"
  count           = length(var.kinesis_s3_cloudwatch_logs_group)
  log_group_name  = element(var.kinesis_s3_cloudwatch_logs_group, count.index)
  filter_pattern  = ""
  destination_arn = element(aws_kinesis_firehose_delivery_stream.firehose_s3.*.arn, count.index)
  role_arn        = var.kinesis_basic_role
  distribution    = "ByLogStream"
}

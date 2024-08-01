resource "aws_cloudtrail" "this" {
  name                          = local.cloudtrail_gmd_prefix
  s3_bucket_name                = aws_s3_bucket.this.bucket
  include_global_service_events = false
  is_multi_region_trail         = false
  enable_logging                = true
  enable_log_file_validation    = false
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.this.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.this.arn

  advanced_event_selector {
    name = "GetMetricData"

    field_selector {
      field  = "eventCategory"
      equals = ["Data"]
    }

    field_selector {
      field  = "resources.type"
      equals = ["AWS::CloudWatch::Metric"]
    }

    field_selector {
      field  = "eventName"
      equals = ["GetMetricData"]
    }
  }
}

resource "aws_s3_bucket" "this" {
  bucket = local.cloudtrail_gmd_prefix
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.bucket
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AWSCloudTrailAclCheck",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action" : "s3:GetBucketAcl",
        "Resource" : "arn:aws:s3:::${local.cloudtrail_gmd_prefix}"
      },
      {
        "Sid" : "AWSCloudTrailWrite",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::${local.cloudtrail_gmd_prefix}/*",
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

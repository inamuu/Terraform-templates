resource "aws_cloudwatch_event_rule" "stop_db_clusters" {
  for_each    = var.stop_db_clusters
  name        = "stop-db-cluster-${each.value["cluster"]}"
  description = "stop-db-cluster-${each.value["cluster"]}"

  event_pattern = jsonencode({
    "detail-type" : ["RDS DB Instance Event"],
    "source" : ["aws.rds"],
    "detail" : {
      "EventCategories" : ["configuration change"],
      "SourceType" : ["DB_INSTANCE"],
      "SourceArn" : ["arn:aws:rds:ap-northeast-1:${var.aws_account_id}:db:${each.value["instance"]}"],
      "Message" : ["Finished updating DB parameter group"]
    }
  })
}

resource "aws_cloudwatch_event_target" "stop_db_clusters" {
  for_each = var.stop_db_clusters
  arn      = "arn:aws:ssm:ap-northeast-1::automation-definition/AWS-StartStopAuroraCluster:$DEFAULT"
  rule     = aws_cloudwatch_event_rule.stop_db_clusters[each.key].name
  role_arn = aws_iam_role.stop_db_clusters.arn
  input    = <<INPUT
{
    "Action": [
        "Stop"
    ],
    "ClusterName": [
        "${each.value["cluster"]}"
    ]
}
INPUT
}

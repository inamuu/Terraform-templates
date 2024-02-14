resource "aws_iam_role" "stop_db_clusters" {
  name               = "automation-stop-db-clusters"
  assume_role_policy = data.aws_iam_policy_document.stop_db_clusters.json
  inline_policy {
    name = "automation-stop-db-clusters"
    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Sid" : "rds",
            "Effect" : "Allow",
            "Action" : [
              "rds:StopDBCluster",
              "rds:DescribeDBClusters"
            ],
            "Resource" : [
              "arn:aws:rds:ap-northeast-1:${var.aws_account_id}:cluster:example-cluster-01",
              "arn:aws:rds:ap-northeast-1:${var.aws_account_id}:cluster:example-cluster-02"
            ]
          },
          {
            "Sid" : "ssm",
            "Effect" : "Allow",
            "Action" : "ssm:*",
            "Resource" : "*"
          }
        ]
      }

    )
  }
}

data "aws_iam_policy_document" "stop_db_clusters" {
  statement {
    sid    = "StopDBClusters"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "rds.amazonaws.com",
        "ssm.amazonaws.com",
        "events.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

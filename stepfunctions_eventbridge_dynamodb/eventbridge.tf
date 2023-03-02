resource "aws_iam_role" "eventbridge_scheduler" {
  name               = "${var.default_prefix}-${random_id.specify_id.hex}-EventBridge-Scheduler"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_scheduler_assume_policy.json
  inline_policy {
    name = "evnetbridge-scheduler-role-inline-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "states:StartExecution",
          ]
          Effect   = "Allow"
          Resource = aws_sfn_state_machine.state_machine.arn
        },
      ]
    })
  }
}

data "aws_iam_policy_document" "eventbridge_scheduler_assume_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "scheduler.amazonaws.com",
      ]
    }
  }
}

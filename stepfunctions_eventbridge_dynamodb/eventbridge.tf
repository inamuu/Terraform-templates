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

resource "aws_scheduler_schedule" "scheduler" {
  name                         = "${var.default_prefix}-${random_id.specify_id.hex}"
  state                        = "DISABLED"
  schedule_expression          = "cron(*/2 18 * * ? *)"
  schedule_expression_timezone = "Asia/Tokyo"
  flexible_time_window {
    mode = "OFF"
  }
  target {
    arn      = aws_sfn_state_machine.state_machine.arn
    role_arn = aws_iam_role.eventbridge_scheduler.arn
    input    = <<EOT
{
  "Name" : "event-schedule-test",
  "id"   : "<aws.scheduler.execution-id>"
}
EOT
  }
}

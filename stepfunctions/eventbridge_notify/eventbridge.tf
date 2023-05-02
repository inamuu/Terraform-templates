resource "aws_cloudwatch_event_rule" "sfn" {
  name        = "${var.default_prefix}-${random_id.specify_id.hex}"
  description = "${var.default_prefix}-${random_id.specify_id.hex}"

  event_pattern = jsonencode({
    "source" : ["aws.states"],
    "detail-type" : ["Step Functions Execution Status Change"],
    "detail" : {
      "stateMachineArn" : [
        aws_sfn_state_machine.state_machine.arn
      ]
    }
  })
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.sfn.name
  target_id = "${var.default_prefix}-${random_id.specify_id.hex}"
  arn       = aws_sns_topic.chatbot.arn
}

resource "aws_sns_topic" "chatbot" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}"
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.chatbot.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "${var.default_prefix}-${random_id.specify_id.hex}-policy-id"

  statement {
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.aws_account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.chatbot.arn,
    ]

    sid = "__default_statement_ID_1"
  }

  statement {
    actions = [
      "SNS:Publish"
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.chatbot.arn,
    ]

    sid = "__default_statement_ID_2"
  }
}

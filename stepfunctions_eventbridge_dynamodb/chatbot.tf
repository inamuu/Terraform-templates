variable "slack_channel_id" {}
variable "slack_workspace_id" {}

resource "aws_iam_role" "chatbot" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}-ChatbotRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "chatbot.amazonaws.com"
        }
      }
    ]
  })
}

resource "awscc_chatbot_slack_channel_configuration" "slack_channge_config" {
  configuration_name = "${var.default_prefix}-${random_id.specify_id.hex}"
  iam_role_arn       = aws_iam_role.chatbot.arn
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id
}

#resource "awscc_chatbot_slack_configuration" "slack_config" {
#  configuration_name = "${var.default_prefix}-${random_id.specify_id.hex}"
#  bot_name           = "${var.default_prefix}-${random_id.specify_id.hex}"
#  slack_channel_id   = var.slack_channel_id
#}

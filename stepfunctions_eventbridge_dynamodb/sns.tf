resource "aws_sns_topic" "sns_topic" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}"
}

resource "aws_sns_topic_policy" "aws_sns_topic_policy" {
  arn = aws_sns_topic.sns_topic.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "chatbot.amazonaws.com"
        }
        Action   = "sns:Publish"
        Resource = aws_sns_topic.sns_topic.arn
      }
    ]
  })
}

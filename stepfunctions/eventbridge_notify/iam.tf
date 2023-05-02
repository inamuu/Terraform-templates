### StepFunctions
resource "aws_iam_role" "stepfunctions" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.ap-northeast-1.amazonaws.com"
        }
      }
    ]
  })

}

### Chatbot
resource "aws_iam_role" "chatbot" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}-chatbot-role"

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

  inline_policy {
    name = "${var.default_prefix}-${random_id.specify_id.hex}-chatbot-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "cloudwatch:Describe*",
            "cloudwatch:Get*",
            "cloudwatch:List*"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}

